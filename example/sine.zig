const std = @import("std");
const pa = @import("pulseaudio");

const Pulse = struct {
    state: pa.context.state_t,
    stream_state: pa.stream.state_t,
    main_loop: *pa.threaded_mainloop,
};

pub fn main() !void {
    const main_loop = try pa.threaded_mainloop.new();
    defer main_loop.free();

    const props = try pa.proplist.new();
    defer props.free();

    try props.sets("media.role", "music");
    try props.sets("media.software", "my cool app");
    try props.sets("media.title", "song title");
    try props.sets("media.artist", "song artist");

    const context = try pa.context.new_with_proplist(main_loop.get_api(), "sine example", props);
    defer context.unref();

    try context.connect(null, .{}, null);
    defer context.disconnect();

    var pulse: Pulse = .{
        .state = .UNCONNECTED,
        .stream_state = .UNCONNECTED,
        .main_loop = main_loop,
    };
    context.set_state_callback(contextStateCallback, &pulse);

    try main_loop.start();
    defer main_loop.stop();

    {
        // Block until ready.
        main_loop.lock();
        defer main_loop.unlock();

        while (true) {
            main_loop.wait();
            switch (pulse.state) {
                .READY => break,
                .FAILED => return error.Failed,
                .TERMINATED => return error.Terminated,
                else => continue,
            }
        }
    }

    {
        // Open output stream.
        main_loop.lock();
        defer main_loop.unlock();

        const sample_spec: pa.sample_spec = .{
            .format = .FLOAT32LE,
            .rate = 48000,
            .channels = 2,
        };
        const channel_map: pa.channel_map = .{
            .channels = 2,
            .map = .{ .LEFT, .RIGHT } ++ .{.INVALID} ** 30,
        };
        const stream = try pa.stream.new_with_proplist(context, "main stream", &sample_spec, &channel_map, props);

        stream.set_state_callback(streamStateCallback, &pulse);
        stream.set_write_callback(streamWriteCallback, &pulse);

        try stream.connect_playback(null, null, .{
            .START_CORKED = true,
            .AUTO_TIMING_UPDATE = true,
            .INTERPOLATE_TIMING = true,
            .FIX_FORMAT = true,
            .FIX_RATE = true,
            .FIX_CHANNELS = true,
        }, null, null);

        while (true) {
            main_loop.wait();
            switch (pulse.stream_state) {
                .READY => break,
                .FAILED => return error.StreamFailed,
                .TERMINATED => return error.StreamTerminated,
                else => continue,
            }
        }

        const fixed_sample_spec = stream.get_sample_spec();
        const fixed_channel_map = stream.get_channel_map();
        std.log.info("fixed_sample_spec={any}", .{fixed_sample_spec});
        for (fixed_channel_map.map[0..fixed_channel_map.channels], 0..) |channel, i| {
            std.log.info("fixed_channel_map[{d}]={s}", .{ i, @tagName(channel) });
        }

        const op = try stream.cork(0, null, null);
        op.unref();

        while (true) {
            main_loop.wait();
            switch (pulse.stream_state) {
                .FAILED => return error.StreamFailed,
                .TERMINATED => return error.StreamTerminated,
                else => continue,
            }
        }
    }
}

fn contextStateCallback(context: *pa.context, userdata: ?*anyopaque) callconv(.c) void {
    const pulse: *Pulse = @ptrCast(@alignCast(userdata));
    pulse.state = context.get_state();
    std.log.info("context state: {s}", .{@tagName(pulse.state)});
    switch (pulse.state) {
        .UNCONNECTED, .CONNECTING, .AUTHORIZING, .SETTING_NAME => return,
        .READY, .FAILED, .TERMINATED => pulse.main_loop.signal(0),
    }
}

fn streamStateCallback(stream: *pa.stream, userdata: ?*anyopaque) callconv(.c) void {
    const pulse: *Pulse = @ptrCast(@alignCast(userdata));
    pulse.stream_state = stream.get_state();
    std.log.info("stream state: {s}", .{@tagName(pulse.stream_state)});
    switch (pulse.stream_state) {
        .UNCONNECTED, .CREATING => return,
        .READY, .FAILED, .TERMINATED => pulse.main_loop.signal(0),
    }
}

fn streamWriteCallback(stream: *pa.stream, requested_bytes: usize, userdata: ?*anyopaque) callconv(.c) void {
    const pulse: *Pulse = @ptrCast(@alignCast(userdata));
    _ = pulse;
    std.log.info("requested bytes: {d}", .{requested_bytes});
    var remaining_bytes = requested_bytes;
    while (remaining_bytes > 0) {
        var ptr_len: usize = remaining_bytes;
        var opt_ptr: ?[*]i32 = null;
        stream.begin_write(@ptrCast(&opt_ptr), &ptr_len) catch @panic("unhandleable error");
        const ptr = opt_ptr orelse @panic("unhandleable error");
        const write_len = @min(ptr_len, remaining_bytes);
        @memset(ptr[0..write_len], 0);
        stream.write(ptr, write_len, null, 0, .RELATIVE) catch @panic("unhandleable error");
        remaining_bytes -= write_len;
        std.log.info("wrote {d} bytes, {d} remaining", .{ write_len, remaining_bytes });
    }
}
