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
        const stream = try pa.stream.new(context, "main stream", &sample_spec, &channel_map);

        stream.set_state_callback(streamStateCallback, &pulse);

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
    }

    //stream.set_write_callback(writeCallback, &pulse);
}

fn contextStateCallback(context: *pa.context, pulse_opaque: ?*anyopaque) callconv(.c) void {
    const pulse: *Pulse = @ptrCast(@alignCast(pulse_opaque));
    pulse.state = context.get_state();
    std.log.info("context state: {s}", .{@tagName(pulse.state)});
    switch (pulse.state) {
        .UNCONNECTED, .CONNECTING, .AUTHORIZING, .SETTING_NAME => return,
        .READY, .FAILED, .TERMINATED => pulse.main_loop.signal(0),
    }
}

fn streamStateCallback(stream: *pa.stream, pulse_opaque: ?*anyopaque) callconv(.c) void {
    const pulse: *Pulse = @ptrCast(@alignCast(pulse_opaque));
    pulse.stream_state = stream.get_state();
    std.log.info("stream state: {s}", .{@tagName(pulse.stream_state)});
    switch (pulse.stream_state) {
        .UNCONNECTED, .CREATING => return,
        .READY, .FAILED, .TERMINATED => pulse.main_loop.signal(0),
    }
}
