//! An example of using pulseaudio's mainloop API to render a sine wave.
const std = @import("std");
const pa = @import("pulseaudio");
const sine = @import("sine.zig");

pub fn main() !void {
    const main_loop = try pa.mainloop.new();
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

    {
        var state: ?pa.context.state_t = null;
        while (true) {
            const new_state = context.get_state();
            if (new_state != state) {
                state = new_state;
                std.log.info("context state: {s}", .{@tagName(new_state)});
                switch (new_state) {
                    .UNCONNECTED, .CONNECTING, .AUTHORIZING, .SETTING_NAME => {},
                    .READY => break,
                    .FAILED => {
                        const errno = context.errno();
                        errExit("connect context failed, errno={} ({s})", .{ errno, pa.strerror(errno) });
                    },
                    .TERMINATED => unreachable,
                }
            }
            if (main_loop.iterate(.blocking, null) < 0) {
                const errno = context.errno();
                errExit("connect context failed, errno={} ({s})", .{ errno, pa.strerror(errno) });
            }
        }
    }

    var sine_phase: f32 = 0;

    {
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

        stream.set_write_callback(streamWriteCallback, &sine_phase);

        try stream.connect_playback(null, null, .{
            .START_CORKED = true,
            .AUTO_TIMING_UPDATE = true,
            .INTERPOLATE_TIMING = true,
            .FIX_FORMAT = true,
            .FIX_RATE = true,
            .FIX_CHANNELS = true,
        }, null, null);

        var state: ?pa.stream.state_t = null;
        while (true) {
            const new_state = stream.get_state();
            if (new_state != state) {
                std.log.info("stream state: {s}", .{@tagName(new_state)});
                state = new_state;
                switch (new_state) {
                    .UNCONNECTED, .CREATING => {},
                    .READY => break,
                    .FAILED => {
                        const errno = context.errno();
                        errExit("connect stream failed, errno={} ({s})", .{ errno, pa.strerror(errno) });
                    },
                    .TERMINATED => unreachable,
                }
            }

            if (main_loop.iterate(.blocking, null) < 0) {
                const errno = context.errno();
                errExit("mainloop iterate failed while connecting stream, errno={} ({s})", .{ errno, pa.strerror(errno) });
            }
        }

        const fixed_sample_spec = stream.get_sample_spec();
        const fixed_channel_map = stream.get_channel_map();
        std.log.info("fixed_sample_spec={}-channel {}Hz {s}", .{
            fixed_sample_spec.channels,
            fixed_sample_spec.rate,
            @tagName(fixed_sample_spec.format),
        });
        for (fixed_channel_map.map[0..fixed_channel_map.channels], 0..) |channel, i| {
            std.log.info("fixed_channel_map[{d}]={s}", .{ i, @tagName(channel) });
        }
        const op = try stream.cork(0, null, null);
        op.unref();
    }

    var quit_result: c_int = undefined;
    if (0 != main_loop.run(&quit_result)) {
        const errno = context.errno();
        errExit("mainloop failure, errno={} ({s})", .{ errno, pa.strerror(errno) });
    }
    std.debug.assert(quit_result == 0);
}

fn streamWriteCallback(stream: *pa.stream, requested_bytes: usize, userdata: ?*anyopaque) callconv(.c) void {
    const sine_phase_ref: *f32 = @ptrCast(@alignCast(userdata.?));
    const sample_spec = stream.get_sample_spec();
    std.log.info("requested bytes: {d}", .{requested_bytes});
    var remaining_bytes = requested_bytes;
    while (remaining_bytes > 0) {
        var ptr_len: usize = remaining_bytes;
        var opt_ptr: ?[*]u8 = null;
        stream.begin_write(@ptrCast(&opt_ptr), &ptr_len) catch @panic("unhandleable error");
        const ptr = opt_ptr orelse @panic("unhandleable error");
        const write_len = @min(ptr_len, remaining_bytes);
        sine.render(sine_phase_ref, sample_spec.*, ptr, write_len);
        stream.write(ptr, write_len, null, 0, .RELATIVE) catch @panic("unhandleable error");
        remaining_bytes -= write_len;
        std.log.info("wrote {d} bytes, {d} remaining", .{ write_len, remaining_bytes });
    }
}

fn errExit(comptime fmt: []const u8, args: anytype) noreturn {
    std.log.err(fmt, args);
    std.process.exit(1);
}
