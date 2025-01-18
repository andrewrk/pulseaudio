const std = @import("std");
const pa = @import("pulseaudio");

const Pulse = struct {
    state: pa.context.state_t,
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
        .main_loop = main_loop,
    };
    context.set_state_callback(stateCallback, &pulse);

    try main_loop.start();
    defer main_loop.stop();

    main_loop.lock();
    defer main_loop.unlock();

    // Block until ready.
    while (true) {
        main_loop.wait();
        switch (pulse.state) {
            .READY => break,
            .FAILED => return error.Failed,
            .TERMINATED => return error.Terminated,
            else => continue,
        }
    }

    //ospa->stream = pa_stream_new(sipa->pulse_context, outstream->name, &sample_spec, &channel_map);

}

fn stateCallback(context: *pa.context, my_context_opaque: ?*anyopaque) callconv(.c) void {
    const pulse: *Pulse = @ptrCast(@alignCast(my_context_opaque));
    pulse.state = context.get_state();
    std.log.info("state: {s}", .{@tagName(pulse.state)});
    switch (pulse.state) {
        .UNCONNECTED, .CONNECTING, .AUTHORIZING, .SETTING_NAME => return,
        .READY, .FAILED, .TERMINATED => pulse.main_loop.signal(0),
    }
}
