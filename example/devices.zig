//! An example of using pulseaudio to list devices.
const std = @import("std");
const pa = @import("pulseaudio");
const fatal = std.process.fatal;

const Pulse = struct {
    context: *pa.context,
    state: pa.context.state_t,
    main_loop: *pa.threaded_mainloop,
    device_scan_queued: bool,

    fn waitOperation(p: *Pulse, op: *pa.operation) error{OperationCanceled}!void {
        while (true) switch (op.get_state()) {
            .RUNNING => {
                p.main_loop.wait();
                continue;
            },
            .DONE => return,
            .CANCELLED => return error.OperationCanceled,
        };
    }
};

pub fn main() !void {
    const main_loop = try pa.threaded_mainloop.new();
    defer main_loop.free();

    const context = try pa.context.new(main_loop.get_api(), "devices example");
    defer context.unref();

    try context.connect(null, .{}, null);
    defer context.disconnect();

    var pulse: Pulse = .{
        .context = context,
        .state = .UNCONNECTED,
        .main_loop = main_loop,
        .device_scan_queued = true,
    };

    context.set_state_callback(contextStateCallback, &pulse);
    context.set_subscribe_callback(subscribeCallback, &pulse);

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

    while (true) {
        main_loop.lock();
        defer main_loop.unlock();

        if (pulse.device_scan_queued) {
            {
                const list_sink_op = try context.get_sink_info_list(sinkInfoCallback, &pulse);
                defer list_sink_op.unref();
                const list_source_op = try context.get_source_info_list(sourceInfoCallback, &pulse);
                defer list_source_op.unref();
                const server_info_op = try context.get_server_info(serverInfoCallback, &pulse);
                defer server_info_op.unref();

                try pulse.waitOperation(list_source_op);
                try pulse.waitOperation(list_sink_op);
                try pulse.waitOperation(server_info_op);
            }
        }
        main_loop.wait();
        switch (pulse.state) {
            .FAILED => return error.Failed,
            .TERMINATED => return error.Terminated,
            else => continue,
        }
    }
}

fn contextStateCallback(context: *pa.context, userdata: ?*anyopaque) callconv(.c) void {
    const p: *Pulse = @ptrCast(@alignCast(userdata));
    p.state = context.get_state();
    std.log.info("context state: {t}", .{p.state});
    switch (p.state) {
        .UNCONNECTED, .CONNECTING, .AUTHORIZING, .SETTING_NAME => return,
        .READY, .FAILED, .TERMINATED => p.main_loop.signal(0),
    }
}

fn subscribeCallback(
    context: *pa.context,
    event: pa.subscription_event_type_t,
    index: u32,
    userdata: ?*anyopaque,
) callconv(.c) void {
    _ = context;
    const p: *Pulse = @ptrCast(@alignCast(userdata));
    std.log.info("subscription event: {any} index {d}", .{ event, index });
    p.device_scan_queued = true;
    p.main_loop.signal(0);
}

fn sinkInfoCallback(context: *pa.context, info: *const pa.sink_info, eol: c_int, userdata: ?*anyopaque) callconv(.c) void {
    _ = context;
    const p: *Pulse = @ptrCast(@alignCast(userdata));

    if (eol != 0) {
        p.main_loop.signal(0);
        return;
    }

    std.log.info("sink: name={s} description={s} sample_rate={d} format={t} channels={d}", .{
        info.name, info.description, info.sample_spec.rate, info.sample_spec.format, info.sample_spec.channels,
    });
}

fn sourceInfoCallback(context: *pa.context, info: *const pa.source_info, eol: c_int, userdata: ?*anyopaque) callconv(.c) void {
    _ = context;
    const p: *Pulse = @ptrCast(@alignCast(userdata));

    if (eol != 0) {
        p.main_loop.signal(0);
        return;
    }

    std.log.info("source: name={s} description={s} sample_rate={d} format={t} channels={d}", .{
        info.name, info.description, info.sample_spec.rate, info.sample_spec.format, info.sample_spec.channels,
    });
}

fn serverInfoCallback(context: *pa.context, info: *const pa.server_info, userdata: ?*anyopaque) callconv(.c) void {
    _ = context;
    const p: *Pulse = @ptrCast(@alignCast(userdata));

    std.log.info("server: name={s} version={s} default_sink={s} default_source={s}", .{
        info.server_version,
        info.server_name,
        info.default_sink_name,
        info.default_source_name,
    });

    p.main_loop.signal(0);
}
