const pa = @import("pulseaudio");

pub fn main() !void {
    const main_loop = pa.threaded_mainloop.new() orelse return error.OutOfMemory;
    defer main_loop.free();

    const props = pa.proplist.new() orelse return error.OutOfMemory;
    defer props.free();

    //const context = pa.context.new_with_proplist(main_loop.get_api(), "sine example", props);
    //defer context.unref();
}
