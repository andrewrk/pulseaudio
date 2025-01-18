const std = @import("std");
const library_name = "pulse";

pub const get_library_version = @extern(*const fn () [*:0]const u8, .{
    .name = "pa_get_library_version",
    .library_name = library_name,
});
pub const pa_sample_spec = struct_pa_sample_spec;
pub const struct_pa_sample_spec = extern struct {
    format: pa_sample_format_t,
    rate: u32,
    channels: u8,
};
pub const pa_sample_format_t = enum_pa_sample_format;
pub const enum_pa_sample_format = enum(c_int) {
    U8 = 0,
    ALAW = 1,
    ULAW = 2,
    S16LE = 3,
    S16BE = 4,
    FLOAT32LE = 5,
    FLOAT32BE = 6,
    S32LE = 7,
    S32BE = 8,
    S24LE = 9,
    S24BE = 10,
    S24_32LE = 11,
    S24_32BE = 12,
    MAX = 13,
    INVALID = -1,
};
pub const pa_usec_t = u64;
pub const enum_pa_direction = enum(c_uint) {
    OUTPUT = 1,
    INPUT = 2,
};
pub const pa_direction_t = enum_pa_direction;
pub const pa_mainloop_api = struct_pa_mainloop_api;
pub const struct_pa_mainloop_api = extern struct {
    userdata: ?*anyopaque,
    io_new: ?*const fn ([*c]pa_mainloop_api, c_int, pa_io_event_flags_t, pa_io_event_cb_t, ?*anyopaque) callconv(.c) ?*pa_io_event,
    io_enable: ?*const fn (?*pa_io_event, pa_io_event_flags_t) callconv(.c) void,
    io_free: ?*const fn (?*pa_io_event) callconv(.c) void,
    io_set_destroy: ?*const fn (?*pa_io_event, pa_io_event_destroy_cb_t) callconv(.c) void,
    time_new: ?*const fn ([*c]pa_mainloop_api, [*c]const std.c.timeval, pa_time_event_cb_t, ?*anyopaque) callconv(.c) ?*pa_time_event,
    time_restart: ?*const fn (?*pa_time_event, [*c]const std.c.timeval) callconv(.c) void,
    time_free: ?*const fn (?*pa_time_event) callconv(.c) void,
    time_set_destroy: ?*const fn (?*pa_time_event, pa_time_event_destroy_cb_t) callconv(.c) void,
    defer_new: ?*const fn ([*c]pa_mainloop_api, pa_defer_event_cb_t, ?*anyopaque) callconv(.c) ?*pa_defer_event,
    defer_enable: ?*const fn (?*pa_defer_event, c_int) callconv(.c) void,
    defer_free: ?*const fn (?*pa_defer_event) callconv(.c) void,
    defer_set_destroy: ?*const fn (?*pa_defer_event, pa_defer_event_destroy_cb_t) callconv(.c) void,
    quit: ?*const fn ([*c]pa_mainloop_api, c_int) callconv(.c) void,
};
pub const pa_io_event_cb_t = ?*const fn ([*c]pa_mainloop_api, ?*pa_io_event, c_int, pa_io_event_flags_t, ?*anyopaque) callconv(.c) void;
pub const pa_time_event_cb_t = ?*const fn ([*c]pa_mainloop_api, ?*pa_time_event, [*c]const std.c.timeval, ?*anyopaque) callconv(.c) void;
pub const pa_io_event_destroy_cb_t = ?*const fn ([*c]pa_mainloop_api, ?*pa_io_event, ?*anyopaque) callconv(.c) void;
pub const pa_time_event_destroy_cb_t = ?*const fn ([*c]pa_mainloop_api, ?*pa_time_event, ?*anyopaque) callconv(.c) void;
pub const pa_defer_event_cb_t = ?*const fn ([*c]pa_mainloop_api, ?*pa_defer_event, ?*anyopaque) callconv(.c) void;
pub const pa_defer_event_destroy_cb_t = ?*const fn ([*c]pa_mainloop_api, ?*pa_defer_event, ?*anyopaque) callconv(.c) void;
pub const pa_operation_notify_cb_t = ?*const fn (?*pa_operation, ?*anyopaque) callconv(.c) void;
pub const pa_context_notify_cb_t = ?*const fn (?*pa_context, ?*anyopaque) callconv(.c) void;
pub const pa_context_event_cb_t = ?*const fn (?*pa_context, [*c]const u8, ?*pa_proplist, ?*anyopaque) callconv(.c) void;
pub const pa_context_success_cb_t = ?*const fn (?*pa_context, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_free_cb_t = ?*const fn (?*anyopaque) callconv(.c) void;
pub const pa_stream_success_cb_t = ?*const fn (?*pa_stream, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_stream_notify_cb_t = ?*const fn (?*pa_stream, ?*anyopaque) callconv(.c) void;
pub const pa_stream_request_cb_t = ?*const fn (?*pa_stream, usize, ?*anyopaque) callconv(.c) void;
pub const pa_stream_event_cb_t = ?*const fn (?*pa_stream, [*c]const u8, ?*pa_proplist, ?*anyopaque) callconv(.c) void;
pub const pa_sink_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_sink_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_source_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_source_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_server_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_server_info, ?*anyopaque) callconv(.c) void;
pub const pa_module_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_module_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_context_index_cb_t = ?*const fn (?*pa_context, u32, ?*anyopaque) callconv(.c) void;
pub const pa_context_string_cb_t = ?*const fn (?*pa_context, c_int, [*c]u8, ?*anyopaque) callconv(.c) void;
pub const pa_client_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_client_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_card_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_card_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_sink_input_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_sink_input_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_source_output_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_source_output_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_stat_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_stat_info, ?*anyopaque) callconv(.c) void;
pub const pa_sample_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_sample_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_autoload_info_cb_t = ?*const fn (?*pa_context, [*c]const pa_autoload_info, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_signal_cb_t = ?*const fn ([*c]pa_mainloop_api, ?*pa_signal_event, c_int, ?*anyopaque) callconv(.c) void;
pub const pa_context_subscribe_cb_t = ?*const fn (?*pa_context, pa_subscription_event_type_t, u32, ?*anyopaque) callconv(.c) void;
pub const pa_context_play_sample_cb_t = ?*const fn (?*pa_context, u32, ?*anyopaque) callconv(.c) void;
pub const pa_signal_destroy_cb_t = ?*const fn ([*c]pa_mainloop_api, ?*pa_signal_event, ?*anyopaque) callconv(.c) void;

pub const enum_pa_io_event_flags = enum(c_uint) {
    NULL = 0,
    INPUT = 1,
    OUTPUT = 2,
    HANGUP = 4,
    ERROR = 8,
};
pub const pa_io_event_flags_t = enum_pa_io_event_flags;
pub const struct_pa_io_event = opaque {};
pub const pa_io_event = struct_pa_io_event;
pub const struct_pa_time_event = opaque {};
pub const pa_time_event = struct_pa_time_event;
pub const struct_pa_defer_event = opaque {};
pub const pa_defer_event = struct_pa_defer_event;
pub const struct_pa_proplist = opaque {};
pub const pa_proplist = struct_pa_proplist;
pub const enum_pa_update_mode = enum(c_uint) {
    SET = 0,
    MERGE = 1,
    REPLACE = 2,
};
pub const pa_update_mode_t = enum_pa_update_mode;
pub const struct_pa_channel_map = extern struct {
    channels: u8,
    map: [32]pa_channel_position_t,
};
pub const pa_channel_map = struct_pa_channel_map;
pub const enum_pa_channel_position = enum(c_int) {
    INVALID = -1,
    MONO = 0,
    FRONT_LEFT = 1,
    FRONT_RIGHT = 2,
    FRONT_CENTER = 3,
    LEFT = 1,
    RIGHT = 2,
    CENTER = 3,
    REAR_CENTER = 4,
    REAR_LEFT = 5,
    REAR_RIGHT = 6,
    LFE = 7,
    SUBWOOFER = 7,
    FRONT_LEFT_OF_CENTER = 8,
    FRONT_RIGHT_OF_CENTER = 9,
    SIDE_LEFT = 10,
    SIDE_RIGHT = 11,
    AUX0 = 12,
    AUX1 = 13,
    AUX2 = 14,
    AUX3 = 15,
    AUX4 = 16,
    AUX5 = 17,
    AUX6 = 18,
    AUX7 = 19,
    AUX8 = 20,
    AUX9 = 21,
    AUX10 = 22,
    AUX11 = 23,
    AUX12 = 24,
    AUX13 = 25,
    AUX14 = 26,
    AUX15 = 27,
    AUX16 = 28,
    AUX17 = 29,
    AUX18 = 30,
    AUX19 = 31,
    AUX20 = 32,
    AUX21 = 33,
    AUX22 = 34,
    AUX23 = 35,
    AUX24 = 36,
    AUX25 = 37,
    AUX26 = 38,
    AUX27 = 39,
    AUX28 = 40,
    AUX29 = 41,
    AUX30 = 42,
    AUX31 = 43,
    TOP_CENTER = 44,
    TOP_FRONT_LEFT = 45,
    TOP_FRONT_RIGHT = 46,
    TOP_FRONT_CENTER = 47,
    TOP_REAR_LEFT = 48,
    TOP_REAR_RIGHT = 49,
    TOP_REAR_CENTER = 50,
    MAX = 51,
};
pub const pa_channel_position_t = enum_pa_channel_position;

pub const enum_pa_channel_map_def = enum(c_uint) {
    AIFF = 0,
    ALSA = 1,
    AUX = 2,
    WAVEEX = 3,
    OSS = 4,
    DEF_MAX = 5,
    DEFAULT = 0,
};
pub const pa_channel_map_def_t = enum_pa_channel_map_def;
pub const pa_channel_position_mask_t = u64;

pub const enum_pa_encoding = enum(c_int) {
    ANY = 0,
    PCM = 1,
    AC3_IEC61937 = 2,
    EAC3_IEC61937 = 3,
    MPEG_IEC61937 = 4,
    DTS_IEC61937 = 5,
    MPEG2_AAC_IEC61937 = 6,
    TRUEHD_IEC61937 = 7,
    DTSHD_IEC61937 = 8,
    MAX = 9,
    INVALID = -1,
};
pub const pa_encoding_t = enum_pa_encoding;
pub const struct_pa_format_info = extern struct {
    encoding: pa_encoding_t,
    plist: ?*pa_proplist,
};
pub const pa_format_info = struct_pa_format_info;
pub const enum_pa_prop_type_t = enum(c_int) {
    INT = 0,
    INT_RANGE = 1,
    INT_ARRAY = 2,
    STRING = 3,
    STRING_ARRAY = 4,
    INVALID = -1,
};
pub const pa_prop_type_t = enum_pa_prop_type_t;
pub const struct_pa_operation = opaque {};
pub const pa_operation = struct_pa_operation;
pub const enum_pa_operation_state = enum(c_uint) {
    RUNNING = 0,
    DONE = 1,
    CANCELLED = 2,
};
pub const pa_operation_state_t = enum_pa_operation_state;
pub const struct_pa_context = opaque {};
pub const pa_context = struct_pa_context;

pub const enum_pa_context_state = enum(c_uint) {
    UNCONNECTED = 0,
    CONNECTING = 1,
    AUTHORIZING = 2,
    SETTING_NAME = 3,
    READY = 4,
    FAILED = 5,
    TERMINATED = 6,
};
pub const pa_context_state_t = enum_pa_context_state;

pub const enum_pa_context_flags = enum(c_uint) {
    NOFLAGS = 0,
    NOAUTOSPAWN = 1,
    NOFAIL = 2,
};
pub const pa_context_flags_t = enum_pa_context_flags;

pub const struct_pa_spawn_api = extern struct {
    prefork: ?*const fn () callconv(.c) void,
    postfork: ?*const fn () callconv(.c) void,
    atfork: ?*const fn () callconv(.c) void,
};
pub const pa_spawn_api = struct_pa_spawn_api;
pub const struct_pa_cvolume = extern struct {
    channels: u8,
    values: [32]pa_volume_t,
};
pub const pa_cvolume = struct_pa_cvolume;
pub const pa_volume_t = u32;
pub const struct_pa_stream = opaque {};
pub const pa_stream = struct_pa_stream;

pub const enum_pa_stream_state = enum(c_uint) {
    UNCONNECTED = 0,
    CREATING = 1,
    READY = 2,
    FAILED = 3,
    TERMINATED = 4,
};
pub const pa_stream_state_t = enum_pa_stream_state;
pub const struct_pa_buffer_attr = extern struct {
    maxlength: u32,
    tlength: u32,
    prebuf: u32,
    minreq: u32,
    fragsize: u32,
};
pub const pa_buffer_attr = struct_pa_buffer_attr;

pub const enum_pa_stream_flags = enum(c_uint) {
    NOFLAGS = 0,
    START_CORKED = 1,
    INTERPOLATE_TIMING = 2,
    NOT_MONOTONIC = 4,
    AUTO_TIMING_UPDATE = 8,
    NO_REMAP_CHANNELS = 16,
    NO_REMIX_CHANNELS = 32,
    FIX_FORMAT = 64,
    FIX_RATE = 128,
    FIX_CHANNELS = 256,
    DONT_MOVE = 512,
    VARIABLE_RATE = 1024,
    PEAK_DETECT = 2048,
    START_MUTED = 4096,
    ADJUST_LATENCY = 8192,
    EARLY_REQUESTS = 16384,
    DONT_INHIBIT_AUTO_SUSPEND = 32768,
    START_UNMUTED = 65536,
    FAIL_ON_SUSPEND = 131072,
    RELATIVE_VOLUME = 262144,
    PASSTHROUGH = 524288,
};
pub const pa_stream_flags_t = enum_pa_stream_flags;

pub const enum_pa_seek_mode = enum(c_uint) {
    RELATIVE = 0,
    ABSOLUTE = 1,
    RELATIVE_ON_READ = 2,
    RELATIVE_END = 3,
};
pub const pa_seek_mode_t = enum_pa_seek_mode;
pub const struct_pa_timing_info = extern struct {
    timestamp: std.c.timeval,
    synchronized_clocks: c_int,
    sink_usec: pa_usec_t,
    source_usec: pa_usec_t,
    transport_usec: pa_usec_t,
    playing: c_int,
    write_index_corrupt: c_int,
    write_index: i64,
    read_index_corrupt: c_int,
    read_index: i64,
    configured_sink_usec: pa_usec_t,
    configured_source_usec: pa_usec_t,
    since_underrun: i64,
};
pub const pa_timing_info = struct_pa_timing_info;
pub const struct_pa_sink_info = extern struct {
    name: [*c]const u8,
    index: u32,
    description: [*c]const u8,
    sample_spec: pa_sample_spec,
    channel_map: pa_channel_map,
    owner_module: u32,
    volume: pa_cvolume,
    mute: c_int,
    monitor_source: u32,
    monitor_source_name: [*c]const u8,
    latency: pa_usec_t,
    driver: [*c]const u8,
    flags: pa_sink_flags_t,
    proplist: ?*pa_proplist,
    configured_latency: pa_usec_t,
    base_volume: pa_volume_t,
    state: pa_sink_state_t,
    n_volume_steps: u32,
    card: u32,
    n_ports: u32,
    ports: [*c][*c]pa_sink_port_info,
    active_port: [*c]pa_sink_port_info,
    n_formats: u8,
    formats: [*c][*c]pa_format_info,
};
pub const pa_sink_info = struct_pa_sink_info;

pub const enum_pa_sink_flags = enum(c_uint) {
    NOFLAGS = 0,
    HW_VOLUME_CTRL = 1,
    LATENCY = 2,
    HARDWARE = 4,
    NETWORK = 8,
    HW_MUTE_CTRL = 16,
    DECIBEL_VOLUME = 32,
    FLAT_VOLUME = 64,
    DYNAMIC_LATENCY = 128,
    SET_FORMATS = 256,
};
pub const pa_sink_flags_t = enum_pa_sink_flags;

pub const enum_pa_sink_state = enum(c_int) {
    INVALID_STATE = -1,
    RUNNING = 0,
    IDLE = 1,
    SUSPENDED = 2,
    INIT = -2,
    UNLINKED = -3,
};
pub const pa_sink_state_t = enum_pa_sink_state;
pub const struct_pa_sink_port_info = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    priority: u32,
    available: c_int,
    availability_group: [*c]const u8,
    type: u32,
};
pub const pa_sink_port_info = struct_pa_sink_port_info;
pub const struct_pa_source_info = extern struct {
    name: [*c]const u8,
    index: u32,
    description: [*c]const u8,
    sample_spec: pa_sample_spec,
    channel_map: pa_channel_map,
    owner_module: u32,
    volume: pa_cvolume,
    mute: c_int,
    monitor_of_sink: u32,
    monitor_of_sink_name: [*c]const u8,
    latency: pa_usec_t,
    driver: [*c]const u8,
    flags: pa_source_flags_t,
    proplist: ?*pa_proplist,
    configured_latency: pa_usec_t,
    base_volume: pa_volume_t,
    state: pa_source_state_t,
    n_volume_steps: u32,
    card: u32,
    n_ports: u32,
    ports: [*c][*c]pa_source_port_info,
    active_port: [*c]pa_source_port_info,
    n_formats: u8,
    formats: [*c][*c]pa_format_info,
};
pub const pa_source_info = struct_pa_source_info;
pub const struct_pa_server_info = extern struct {
    user_name: [*c]const u8,
    host_name: [*c]const u8,
    server_version: [*c]const u8,
    server_name: [*c]const u8,
    sample_spec: pa_sample_spec,
    default_sink_name: [*c]const u8,
    default_source_name: [*c]const u8,
    cookie: u32,
    channel_map: pa_channel_map,
};
pub const pa_server_info = struct_pa_server_info;
pub const struct_pa_module_info = extern struct {
    index: u32,
    name: [*c]const u8,
    argument: [*c]const u8,
    n_used: u32,
    auto_unload: c_int,
    proplist: ?*pa_proplist,
};
pub const pa_module_info = struct_pa_module_info;
pub const struct_pa_client_info = extern struct {
    index: u32,
    name: [*c]const u8,
    owner_module: u32,
    driver: [*c]const u8,
    proplist: ?*pa_proplist,
};
pub const pa_client_info = struct_pa_client_info;
pub const struct_pa_card_info = extern struct {
    index: u32,
    name: [*c]const u8,
    owner_module: u32,
    driver: [*c]const u8,
    n_profiles: u32,
    profiles: [*c]pa_card_profile_info,
    active_profile: [*c]pa_card_profile_info,
    proplist: ?*pa_proplist,
    n_ports: u32,
    ports: [*c][*c]pa_card_port_info,
    profiles2: [*c][*c]pa_card_profile_info2,
    active_profile2: [*c]pa_card_profile_info2,
};
pub const pa_card_info = struct_pa_card_info;
pub const struct_pa_sink_input_info = extern struct {
    index: u32,
    name: [*c]const u8,
    owner_module: u32,
    client: u32,
    sink: u32,
    sample_spec: pa_sample_spec,
    channel_map: pa_channel_map,
    volume: pa_cvolume,
    buffer_usec: pa_usec_t,
    sink_usec: pa_usec_t,
    resample_method: [*c]const u8,
    driver: [*c]const u8,
    mute: c_int,
    proplist: ?*pa_proplist,
    corked: c_int,
    has_volume: c_int,
    volume_writable: c_int,
    format: [*c]pa_format_info,
};
pub const pa_sink_input_info = struct_pa_sink_input_info;
pub const struct_pa_source_output_info = extern struct {
    index: u32,
    name: [*c]const u8,
    owner_module: u32,
    client: u32,
    source: u32,
    sample_spec: pa_sample_spec,
    channel_map: pa_channel_map,
    buffer_usec: pa_usec_t,
    source_usec: pa_usec_t,
    resample_method: [*c]const u8,
    driver: [*c]const u8,
    proplist: ?*pa_proplist,
    corked: c_int,
    volume: pa_cvolume,
    mute: c_int,
    has_volume: c_int,
    volume_writable: c_int,
    format: [*c]pa_format_info,
};
pub const pa_source_output_info = struct_pa_source_output_info;
pub const struct_pa_stat_info = extern struct {
    memblock_total: u32,
    memblock_total_size: u32,
    memblock_allocated: u32,
    memblock_allocated_size: u32,
    scache_size: u32,
};
pub const pa_stat_info = struct_pa_stat_info;
pub const struct_pa_sample_info = extern struct {
    index: u32,
    name: [*c]const u8,
    volume: pa_cvolume,
    sample_spec: pa_sample_spec,
    channel_map: pa_channel_map,
    duration: pa_usec_t,
    bytes: u32,
    lazy: c_int,
    filename: [*c]const u8,
    proplist: ?*pa_proplist,
};
pub const pa_sample_info = struct_pa_sample_info;
pub const struct_pa_autoload_info = extern struct {
    index: u32,
    name: [*c]const u8,
    type: pa_autoload_type_t,
    module: [*c]const u8,
    argument: [*c]const u8,
};
pub const pa_autoload_info = struct_pa_autoload_info;
pub const struct_pa_signal_event = opaque {};
pub const pa_signal_event = struct_pa_signal_event;
pub const enum_pa_source_flags = enum(c_uint) {
    NOFLAGS = 0,
    HW_VOLUME_CTRL = 1,
    LATENCY = 2,
    HARDWARE = 4,
    NETWORK = 8,
    HW_MUTE_CTRL = 16,
    DECIBEL_VOLUME = 32,
    DYNAMIC_LATENCY = 64,
    FLAT_VOLUME = 128,
};
pub const pa_source_flags_t = enum_pa_source_flags;

pub const enum_pa_source_state = enum(c_int) {
    INVALID_STATE = -1,
    RUNNING = 0,
    IDLE = 1,
    SUSPENDED = 2,
    INIT = -2,
    UNLINKED = -3,
};
pub const pa_source_state_t = enum_pa_source_state;
pub const struct_pa_source_port_info = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    priority: u32,
    available: c_int,
    availability_group: [*c]const u8,
    type: u32,
};
pub const pa_source_port_info = struct_pa_source_port_info;
pub const struct_pa_card_profile_info = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    n_sinks: u32,
    n_sources: u32,
    priority: u32,
};
pub const pa_card_profile_info = struct_pa_card_profile_info;
pub const struct_pa_threaded_mainloop = opaque {};
pub const pa_threaded_mainloop = struct_pa_threaded_mainloop;
pub const struct_pa_card_port_info = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    priority: u32,
    available: c_int,
    direction: c_int,
    n_profiles: u32,
    profiles: [*c][*c]pa_card_profile_info,
    proplist: ?*pa_proplist,
    latency_offset: i64,
    profiles2: [*c][*c]pa_card_profile_info2,
    availability_group: [*c]const u8,
    type: u32,
};
pub const pa_card_port_info = struct_pa_card_port_info;
pub const struct_pa_card_profile_info2 = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    n_sinks: u32,
    n_sources: u32,
    priority: u32,
    available: c_int,
};
pub const pa_card_profile_info2 = struct_pa_card_profile_info2;
pub const enum_pa_autoload_type = enum(c_uint) {
    SINK = 0,
    SOURCE = 1,
};
pub const pa_autoload_type_t = enum_pa_autoload_type;
pub const enum_pa_subscription_mask = enum(c_uint) {
    NULL = 0,
    SINK = 1,
    SOURCE = 2,
    SINK_INPUT = 4,
    SOURCE_OUTPUT = 8,
    MODULE = 16,
    CLIENT = 32,
    SAMPLE_CACHE = 64,
    SERVER = 128,
    AUTOLOAD = 256,
    CARD = 512,
    ALL = 767,
};
pub const pa_subscription_mask_t = enum_pa_subscription_mask;
pub const struct_pa_mainloop = opaque {};
pub const pa_mainloop = struct_pa_mainloop;
pub const enum_pa_subscription_event_type = enum(c_uint) {
    SINK = 0,
    SOURCE = 1,
    SINK_INPUT = 2,
    SOURCE_OUTPUT = 3,
    MODULE = 4,
    CLIENT = 5,
    SAMPLE_CACHE = 6,
    SERVER = 7,
    AUTOLOAD = 8,
    CARD = 9,
    FACILITY_MASK = 15,
    NEW = 0,
    CHANGE = 16,
    REMOVE = 32,
    TYPE_MASK = 48,
};
pub const pa_subscription_event_type_t = enum_pa_subscription_event_type;
pub const pa_poll_func = ?*const fn (?*std.c.pollfd, c_ulong, c_int, ?*anyopaque) callconv(.c) c_int;

pub extern fn pa_bytes_per_second(spec: [*c]const pa_sample_spec) usize;
pub extern fn pa_frame_size(spec: [*c]const pa_sample_spec) usize;
pub extern fn pa_sample_size(spec: [*c]const pa_sample_spec) usize;
pub extern fn pa_sample_size_of_format(f: pa_sample_format_t) usize;
pub extern fn pa_bytes_to_usec(length: u64, spec: [*c]const pa_sample_spec) pa_usec_t;
pub extern fn pa_usec_to_bytes(t: pa_usec_t, spec: [*c]const pa_sample_spec) usize;
pub extern fn pa_sample_spec_init(spec: [*c]pa_sample_spec) [*c]pa_sample_spec;
pub extern fn pa_sample_format_valid(format: c_uint) c_int;
pub extern fn pa_sample_rate_valid(rate: u32) c_int;
pub extern fn pa_channels_valid(channels: u8) c_int;
pub extern fn pa_sample_spec_valid(spec: [*c]const pa_sample_spec) c_int;
pub extern fn pa_sample_spec_equal(a: [*c]const pa_sample_spec, b: [*c]const pa_sample_spec) c_int;
pub extern fn pa_sample_format_to_string(f: pa_sample_format_t) [*c]const u8;
pub extern fn pa_parse_sample_format(format: [*c]const u8) pa_sample_format_t;
pub extern fn pa_sample_spec_snprint(s: [*c]u8, l: usize, spec: [*c]const pa_sample_spec) [*c]u8;
pub extern fn pa_bytes_snprint(s: [*c]u8, l: usize, v: c_uint) [*c]u8;
pub extern fn pa_sample_format_is_le(f: pa_sample_format_t) c_int;
pub extern fn pa_sample_format_is_be(f: pa_sample_format_t) c_int;
pub extern fn pa_direction_valid(direction: pa_direction_t) c_int;
pub extern fn pa_direction_to_string(direction: pa_direction_t) [*c]const u8;
pub extern fn pa_mainloop_api_once(m: [*c]pa_mainloop_api, callback: ?*const fn ([*c]pa_mainloop_api, ?*anyopaque) callconv(.c) void, userdata: ?*anyopaque) void;
pub extern fn pa_proplist_new() ?*pa_proplist;
pub extern fn pa_proplist_free(p: ?*pa_proplist) void;
pub extern fn pa_proplist_key_valid(key: [*c]const u8) c_int;
pub extern fn pa_proplist_sets(p: ?*pa_proplist, key: [*c]const u8, value: [*c]const u8) c_int;
pub extern fn pa_proplist_setp(p: ?*pa_proplist, pair: [*c]const u8) c_int;
pub extern fn pa_proplist_setf(p: ?*pa_proplist, key: [*c]const u8, format: [*c]const u8, ...) c_int;
pub extern fn pa_proplist_set(p: ?*pa_proplist, key: [*c]const u8, data: ?*const anyopaque, nbytes: usize) c_int;
pub extern fn pa_proplist_gets(p: ?*const pa_proplist, key: [*c]const u8) [*c]const u8;
pub extern fn pa_proplist_get(p: ?*const pa_proplist, key: [*c]const u8, data: [*c]?*const anyopaque, nbytes: [*c]usize) c_int;
pub extern fn pa_proplist_update(p: ?*pa_proplist, mode: pa_update_mode_t, other: ?*const pa_proplist) void;
pub extern fn pa_proplist_unset(p: ?*pa_proplist, key: [*c]const u8) c_int;
pub extern fn pa_proplist_unset_many(p: ?*pa_proplist, keys: [*c]const [*c]const u8) c_int;
pub extern fn pa_proplist_iterate(p: ?*const pa_proplist, state: [*c]?*anyopaque) [*c]const u8;
pub extern fn pa_proplist_to_string(p: ?*const pa_proplist) [*c]u8;
pub extern fn pa_proplist_to_string_sep(p: ?*const pa_proplist, sep: [*c]const u8) [*c]u8;
pub extern fn pa_proplist_from_string(str: [*c]const u8) ?*pa_proplist;
pub extern fn pa_proplist_contains(p: ?*const pa_proplist, key: [*c]const u8) c_int;
pub extern fn pa_proplist_clear(p: ?*pa_proplist) void;
pub extern fn pa_proplist_copy(p: ?*const pa_proplist) ?*pa_proplist;
pub extern fn pa_proplist_size(p: ?*const pa_proplist) c_uint;
pub extern fn pa_proplist_isempty(p: ?*const pa_proplist) c_int;
pub extern fn pa_proplist_equal(a: ?*const pa_proplist, b: ?*const pa_proplist) c_int;
pub extern fn pa_channel_map_init(m: [*c]pa_channel_map) [*c]pa_channel_map;
pub extern fn pa_channel_map_init_mono(m: [*c]pa_channel_map) [*c]pa_channel_map;
pub extern fn pa_channel_map_init_stereo(m: [*c]pa_channel_map) [*c]pa_channel_map;
pub extern fn pa_channel_map_init_auto(m: [*c]pa_channel_map, channels: c_uint, def: pa_channel_map_def_t) [*c]pa_channel_map;
pub extern fn pa_channel_map_init_extend(m: [*c]pa_channel_map, channels: c_uint, def: pa_channel_map_def_t) [*c]pa_channel_map;
pub extern fn pa_channel_position_to_string(pos: pa_channel_position_t) [*c]const u8;
pub extern fn pa_channel_position_from_string(s: [*c]const u8) pa_channel_position_t;
pub extern fn pa_channel_position_to_pretty_string(pos: pa_channel_position_t) [*c]const u8;
pub extern fn pa_channel_map_snprint(s: [*c]u8, l: usize, map: [*c]const pa_channel_map) [*c]u8;
pub extern fn pa_channel_map_parse(map: [*c]pa_channel_map, s: [*c]const u8) [*c]pa_channel_map;
pub extern fn pa_channel_map_equal(a: [*c]const pa_channel_map, b: [*c]const pa_channel_map) c_int;
pub extern fn pa_channel_map_valid(map: [*c]const pa_channel_map) c_int;
pub extern fn pa_channel_map_compatible(map: [*c]const pa_channel_map, ss: [*c]const pa_sample_spec) c_int;
pub extern fn pa_channel_map_superset(a: [*c]const pa_channel_map, b: [*c]const pa_channel_map) c_int;
pub extern fn pa_channel_map_can_balance(map: [*c]const pa_channel_map) c_int;
pub extern fn pa_channel_map_can_fade(map: [*c]const pa_channel_map) c_int;
pub extern fn pa_channel_map_can_lfe_balance(map: [*c]const pa_channel_map) c_int;
pub extern fn pa_channel_map_to_name(map: [*c]const pa_channel_map) [*c]const u8;
pub extern fn pa_channel_map_to_pretty_name(map: [*c]const pa_channel_map) [*c]const u8;
pub extern fn pa_channel_map_has_position(map: [*c]const pa_channel_map, p: pa_channel_position_t) c_int;
pub extern fn pa_channel_map_mask(map: [*c]const pa_channel_map) pa_channel_position_mask_t;
pub extern fn pa_encoding_to_string(e: pa_encoding_t) [*c]const u8;
pub extern fn pa_encoding_from_string(encoding: [*c]const u8) pa_encoding_t;
pub extern fn pa_format_info_new() [*c]pa_format_info;
pub extern fn pa_format_info_copy(src: [*c]const pa_format_info) [*c]pa_format_info;
pub extern fn pa_format_info_free(f: [*c]pa_format_info) void;
pub extern fn pa_format_info_valid(f: [*c]const pa_format_info) c_int;
pub extern fn pa_format_info_is_pcm(f: [*c]const pa_format_info) c_int;
pub extern fn pa_format_info_is_compatible(first: [*c]const pa_format_info, second: [*c]const pa_format_info) c_int;
pub extern fn pa_format_info_snprint(s: [*c]u8, l: usize, f: [*c]const pa_format_info) [*c]u8;
pub extern fn pa_format_info_from_string(str: [*c]const u8) [*c]pa_format_info;
pub extern fn pa_format_info_from_sample_spec(ss: [*c]const pa_sample_spec, map: [*c]const pa_channel_map) [*c]pa_format_info;
pub extern fn pa_format_info_to_sample_spec(f: [*c]const pa_format_info, ss: [*c]pa_sample_spec, map: [*c]pa_channel_map) c_int;
pub extern fn pa_format_info_get_prop_type(f: [*c]const pa_format_info, key: [*c]const u8) pa_prop_type_t;
pub extern fn pa_format_info_get_prop_int(f: [*c]const pa_format_info, key: [*c]const u8, v: [*c]c_int) c_int;
pub extern fn pa_format_info_get_prop_int_range(f: [*c]const pa_format_info, key: [*c]const u8, min: [*c]c_int, max: [*c]c_int) c_int;
pub extern fn pa_format_info_get_prop_int_array(f: [*c]const pa_format_info, key: [*c]const u8, values: [*c][*c]c_int, n_values: [*c]c_int) c_int;
pub extern fn pa_format_info_get_prop_string(f: [*c]const pa_format_info, key: [*c]const u8, v: [*c][*c]u8) c_int;
pub extern fn pa_format_info_get_prop_string_array(f: [*c]const pa_format_info, key: [*c]const u8, values: [*c][*c][*c]u8, n_values: [*c]c_int) c_int;
pub extern fn pa_format_info_free_string_array(values: [*c][*c]u8, n_values: c_int) void;
pub extern fn pa_format_info_get_sample_format(f: [*c]const pa_format_info, sf: [*c]pa_sample_format_t) c_int;
pub extern fn pa_format_info_get_rate(f: [*c]const pa_format_info, rate: [*c]u32) c_int;
pub extern fn pa_format_info_get_channels(f: [*c]const pa_format_info, channels: [*c]u8) c_int;
pub extern fn pa_format_info_get_channel_map(f: [*c]const pa_format_info, map: [*c]pa_channel_map) c_int;
pub extern fn pa_format_info_set_prop_int(f: [*c]pa_format_info, key: [*c]const u8, value: c_int) void;
pub extern fn pa_format_info_set_prop_int_array(f: [*c]pa_format_info, key: [*c]const u8, values: [*c]const c_int, n_values: c_int) void;
pub extern fn pa_format_info_set_prop_int_range(f: [*c]pa_format_info, key: [*c]const u8, min: c_int, max: c_int) void;
pub extern fn pa_format_info_set_prop_string(f: [*c]pa_format_info, key: [*c]const u8, value: [*c]const u8) void;
pub extern fn pa_format_info_set_prop_string_array(f: [*c]pa_format_info, key: [*c]const u8, values: [*c][*c]const u8, n_values: c_int) void;
pub extern fn pa_format_info_set_sample_format(f: [*c]pa_format_info, sf: pa_sample_format_t) void;
pub extern fn pa_format_info_set_rate(f: [*c]pa_format_info, rate: c_int) void;
pub extern fn pa_format_info_set_channels(f: [*c]pa_format_info, channels: c_int) void;
pub extern fn pa_format_info_set_channel_map(f: [*c]pa_format_info, map: [*c]const pa_channel_map) void;
pub extern fn pa_operation_ref(o: ?*pa_operation) ?*pa_operation;
pub extern fn pa_operation_unref(o: ?*pa_operation) void;
pub extern fn pa_operation_cancel(o: ?*pa_operation) void;
pub extern fn pa_operation_get_state(o: ?*const pa_operation) pa_operation_state_t;
pub extern fn pa_operation_set_state_callback(o: ?*pa_operation, cb: pa_operation_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_context_new(mainloop: [*c]pa_mainloop_api, name: [*c]const u8) ?*pa_context;
pub extern fn pa_context_new_with_proplist(mainloop: [*c]pa_mainloop_api, name: [*c]const u8, proplist: ?*const pa_proplist) ?*pa_context;
pub extern fn pa_context_unref(c: ?*pa_context) void;
pub extern fn pa_context_ref(c: ?*pa_context) ?*pa_context;
pub extern fn pa_context_set_state_callback(c: ?*pa_context, cb: pa_context_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_context_set_event_callback(p: ?*pa_context, cb: pa_context_event_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_context_errno(c: ?*const pa_context) c_int;
pub extern fn pa_context_is_pending(c: ?*const pa_context) c_int;
pub extern fn pa_context_get_state(c: ?*const pa_context) pa_context_state_t;
pub extern fn pa_context_connect(c: ?*pa_context, server: [*c]const u8, flags: pa_context_flags_t, api: [*c]const pa_spawn_api) c_int;
pub extern fn pa_context_disconnect(c: ?*pa_context) void;
pub extern fn pa_context_drain(c: ?*pa_context, cb: pa_context_notify_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_exit_daemon(c: ?*pa_context, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_default_sink(c: ?*pa_context, name: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_default_source(c: ?*pa_context, name: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_is_local(c: ?*const pa_context) c_int;
pub extern fn pa_context_set_name(c: ?*pa_context, name: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_server(c: ?*const pa_context) [*c]const u8;
pub extern fn pa_context_get_protocol_version(c: ?*const pa_context) u32;
pub extern fn pa_context_get_server_protocol_version(c: ?*const pa_context) u32;
pub extern fn pa_context_proplist_update(c: ?*pa_context, mode: pa_update_mode_t, p: ?*const pa_proplist, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_proplist_remove(c: ?*pa_context, keys: [*c]const [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_index(s: ?*const pa_context) u32;
pub extern fn pa_context_rttime_new(c: ?*const pa_context, usec: pa_usec_t, cb: pa_time_event_cb_t, userdata: ?*anyopaque) ?*pa_time_event;
pub extern fn pa_context_rttime_restart(c: ?*const pa_context, e: ?*pa_time_event, usec: pa_usec_t) void;
pub extern fn pa_context_get_tile_size(c: ?*const pa_context, ss: [*c]const pa_sample_spec) usize;
pub extern fn pa_context_load_cookie_from_file(c: ?*pa_context, cookie_file_path: [*c]const u8) c_int;
pub extern fn pa_cvolume_equal(a: [*c]const pa_cvolume, b: [*c]const pa_cvolume) c_int;
pub extern fn pa_cvolume_init(a: [*c]pa_cvolume) [*c]pa_cvolume;
pub extern fn pa_cvolume_set(a: [*c]pa_cvolume, channels: c_uint, v: pa_volume_t) [*c]pa_cvolume;
pub extern fn pa_cvolume_snprint(s: [*c]u8, l: usize, c: [*c]const pa_cvolume) [*c]u8;
pub extern fn pa_sw_cvolume_snprint_dB(s: [*c]u8, l: usize, c: [*c]const pa_cvolume) [*c]u8;
pub extern fn pa_cvolume_snprint_verbose(s: [*c]u8, l: usize, c: [*c]const pa_cvolume, map: [*c]const pa_channel_map, print_dB: c_int) [*c]u8;
pub extern fn pa_volume_snprint(s: [*c]u8, l: usize, v: pa_volume_t) [*c]u8;
pub extern fn pa_sw_volume_snprint_dB(s: [*c]u8, l: usize, v: pa_volume_t) [*c]u8;
pub extern fn pa_volume_snprint_verbose(s: [*c]u8, l: usize, v: pa_volume_t, print_dB: c_int) [*c]u8;
pub extern fn pa_cvolume_avg(a: [*c]const pa_cvolume) pa_volume_t;
pub extern fn pa_cvolume_avg_mask(a: [*c]const pa_cvolume, cm: [*c]const pa_channel_map, mask: pa_channel_position_mask_t) pa_volume_t;
pub extern fn pa_cvolume_max(a: [*c]const pa_cvolume) pa_volume_t;
pub extern fn pa_cvolume_max_mask(a: [*c]const pa_cvolume, cm: [*c]const pa_channel_map, mask: pa_channel_position_mask_t) pa_volume_t;
pub extern fn pa_cvolume_min(a: [*c]const pa_cvolume) pa_volume_t;
pub extern fn pa_cvolume_min_mask(a: [*c]const pa_cvolume, cm: [*c]const pa_channel_map, mask: pa_channel_position_mask_t) pa_volume_t;
pub extern fn pa_cvolume_valid(v: [*c]const pa_cvolume) c_int;
pub extern fn pa_cvolume_channels_equal_to(a: [*c]const pa_cvolume, v: pa_volume_t) c_int;
pub extern fn pa_sw_volume_multiply(a: pa_volume_t, b: pa_volume_t) pa_volume_t;
pub extern fn pa_sw_cvolume_multiply(dest: [*c]pa_cvolume, a: [*c]const pa_cvolume, b: [*c]const pa_cvolume) [*c]pa_cvolume;
pub extern fn pa_sw_cvolume_multiply_scalar(dest: [*c]pa_cvolume, a: [*c]const pa_cvolume, b: pa_volume_t) [*c]pa_cvolume;
pub extern fn pa_sw_volume_divide(a: pa_volume_t, b: pa_volume_t) pa_volume_t;
pub extern fn pa_sw_cvolume_divide(dest: [*c]pa_cvolume, a: [*c]const pa_cvolume, b: [*c]const pa_cvolume) [*c]pa_cvolume;
pub extern fn pa_sw_cvolume_divide_scalar(dest: [*c]pa_cvolume, a: [*c]const pa_cvolume, b: pa_volume_t) [*c]pa_cvolume;
pub extern fn pa_sw_volume_from_dB(f: f64) pa_volume_t;
pub extern fn pa_sw_volume_to_dB(v: pa_volume_t) f64;
pub extern fn pa_sw_volume_from_linear(v: f64) pa_volume_t;
pub extern fn pa_sw_volume_to_linear(v: pa_volume_t) f64;
pub extern fn pa_cvolume_remap(v: [*c]pa_cvolume, from: [*c]const pa_channel_map, to: [*c]const pa_channel_map) [*c]pa_cvolume;
pub extern fn pa_cvolume_compatible(v: [*c]const pa_cvolume, ss: [*c]const pa_sample_spec) c_int;
pub extern fn pa_cvolume_compatible_with_channel_map(v: [*c]const pa_cvolume, cm: [*c]const pa_channel_map) c_int;
pub extern fn pa_cvolume_get_balance(v: [*c]const pa_cvolume, map: [*c]const pa_channel_map) f32;
pub extern fn pa_cvolume_set_balance(v: [*c]pa_cvolume, map: [*c]const pa_channel_map, new_balance: f32) [*c]pa_cvolume;
pub extern fn pa_cvolume_get_fade(v: [*c]const pa_cvolume, map: [*c]const pa_channel_map) f32;
pub extern fn pa_cvolume_set_fade(v: [*c]pa_cvolume, map: [*c]const pa_channel_map, new_fade: f32) [*c]pa_cvolume;
pub extern fn pa_cvolume_get_lfe_balance(v: [*c]const pa_cvolume, map: [*c]const pa_channel_map) f32;
pub extern fn pa_cvolume_set_lfe_balance(v: [*c]pa_cvolume, map: [*c]const pa_channel_map, new_balance: f32) [*c]pa_cvolume;
pub extern fn pa_cvolume_scale(v: [*c]pa_cvolume, max: pa_volume_t) [*c]pa_cvolume;
pub extern fn pa_cvolume_scale_mask(v: [*c]pa_cvolume, max: pa_volume_t, cm: [*c]const pa_channel_map, mask: pa_channel_position_mask_t) [*c]pa_cvolume;
pub extern fn pa_cvolume_set_position(cv: [*c]pa_cvolume, map: [*c]const pa_channel_map, t: pa_channel_position_t, v: pa_volume_t) [*c]pa_cvolume;
pub extern fn pa_cvolume_get_position(cv: [*c]const pa_cvolume, map: [*c]const pa_channel_map, t: pa_channel_position_t) pa_volume_t;
pub extern fn pa_cvolume_merge(dest: [*c]pa_cvolume, a: [*c]const pa_cvolume, b: [*c]const pa_cvolume) [*c]pa_cvolume;
pub extern fn pa_cvolume_inc_clamp(v: [*c]pa_cvolume, inc: pa_volume_t, limit: pa_volume_t) [*c]pa_cvolume;
pub extern fn pa_cvolume_inc(v: [*c]pa_cvolume, inc: pa_volume_t) [*c]pa_cvolume;
pub extern fn pa_cvolume_dec(v: [*c]pa_cvolume, dec: pa_volume_t) [*c]pa_cvolume;
pub extern fn pa_stream_new(c: ?*pa_context, name: [*c]const u8, ss: [*c]const pa_sample_spec, map: [*c]const pa_channel_map) ?*pa_stream;
pub extern fn pa_stream_new_with_proplist(c: ?*pa_context, name: [*c]const u8, ss: [*c]const pa_sample_spec, map: [*c]const pa_channel_map, p: ?*pa_proplist) ?*pa_stream;
pub extern fn pa_stream_new_extended(c: ?*pa_context, name: [*c]const u8, formats: [*c]const [*c]pa_format_info, n_formats: c_uint, p: ?*pa_proplist) ?*pa_stream;
pub extern fn pa_stream_unref(s: ?*pa_stream) void;
pub extern fn pa_stream_ref(s: ?*pa_stream) ?*pa_stream;
pub extern fn pa_stream_get_state(p: ?*const pa_stream) pa_stream_state_t;
pub extern fn pa_stream_get_context(p: ?*const pa_stream) ?*pa_context;
pub extern fn pa_stream_get_index(s: ?*const pa_stream) u32;
pub extern fn pa_stream_get_device_index(s: ?*const pa_stream) u32;
pub extern fn pa_stream_get_device_name(s: ?*const pa_stream) [*c]const u8;
pub extern fn pa_stream_is_suspended(s: ?*const pa_stream) c_int;
pub extern fn pa_stream_is_corked(s: ?*const pa_stream) c_int;
pub extern fn pa_stream_connect_playback(s: ?*pa_stream, dev: [*c]const u8, attr: [*c]const pa_buffer_attr, flags: pa_stream_flags_t, volume: [*c]const pa_cvolume, sync_stream: ?*pa_stream) c_int;
pub extern fn pa_stream_connect_record(s: ?*pa_stream, dev: [*c]const u8, attr: [*c]const pa_buffer_attr, flags: pa_stream_flags_t) c_int;
pub extern fn pa_stream_disconnect(s: ?*pa_stream) c_int;
pub extern fn pa_stream_begin_write(p: ?*pa_stream, data: [*c]?*anyopaque, nbytes: [*c]usize) c_int;
pub extern fn pa_stream_cancel_write(p: ?*pa_stream) c_int;
pub extern fn pa_stream_write(p: ?*pa_stream, data: ?*const anyopaque, nbytes: usize, free_cb: pa_free_cb_t, offset: i64, seek: pa_seek_mode_t) c_int;
pub extern fn pa_stream_write_ext_free(p: ?*pa_stream, data: ?*const anyopaque, nbytes: usize, free_cb: pa_free_cb_t, free_cb_data: ?*anyopaque, offset: i64, seek: pa_seek_mode_t) c_int;
pub extern fn pa_stream_peek(p: ?*pa_stream, data: [*c]?*const anyopaque, nbytes: [*c]usize) c_int;
pub extern fn pa_stream_drop(p: ?*pa_stream) c_int;
pub extern fn pa_stream_writable_size(p: ?*const pa_stream) usize;
pub extern fn pa_stream_readable_size(p: ?*const pa_stream) usize;
pub extern fn pa_stream_drain(s: ?*pa_stream, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_update_timing_info(p: ?*pa_stream, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_set_state_callback(s: ?*pa_stream, cb: pa_stream_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_write_callback(p: ?*pa_stream, cb: pa_stream_request_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_read_callback(p: ?*pa_stream, cb: pa_stream_request_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_overflow_callback(p: ?*pa_stream, cb: pa_stream_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_get_underflow_index(p: ?*const pa_stream) i64;
pub extern fn pa_stream_set_underflow_callback(p: ?*pa_stream, cb: pa_stream_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_started_callback(p: ?*pa_stream, cb: pa_stream_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_latency_update_callback(p: ?*pa_stream, cb: pa_stream_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_moved_callback(p: ?*pa_stream, cb: pa_stream_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_suspended_callback(p: ?*pa_stream, cb: pa_stream_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_event_callback(p: ?*pa_stream, cb: pa_stream_event_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_set_buffer_attr_callback(p: ?*pa_stream, cb: pa_stream_notify_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_cork(s: ?*pa_stream, b: c_int, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_flush(s: ?*pa_stream, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_prebuf(s: ?*pa_stream, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_trigger(s: ?*pa_stream, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_set_name(s: ?*pa_stream, name: [*c]const u8, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_get_time(s: ?*pa_stream, r_usec: [*c]pa_usec_t) c_int;
pub extern fn pa_stream_get_latency(s: ?*pa_stream, r_usec: [*c]pa_usec_t, negative: [*c]c_int) c_int;
pub extern fn pa_stream_get_timing_info(s: ?*pa_stream) [*c]const pa_timing_info;
pub extern fn pa_stream_get_sample_spec(s: ?*pa_stream) [*c]const pa_sample_spec;
pub extern fn pa_stream_get_channel_map(s: ?*pa_stream) [*c]const pa_channel_map;
pub extern fn pa_stream_get_format_info(s: ?*const pa_stream) [*c]const pa_format_info;
pub extern fn pa_stream_get_buffer_attr(s: ?*pa_stream) [*c]const pa_buffer_attr;
pub extern fn pa_stream_set_buffer_attr(s: ?*pa_stream, attr: [*c]const pa_buffer_attr, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_update_sample_rate(s: ?*pa_stream, rate: u32, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_proplist_update(s: ?*pa_stream, mode: pa_update_mode_t, p: ?*pa_proplist, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_proplist_remove(s: ?*pa_stream, keys: [*c]const [*c]const u8, cb: pa_stream_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_stream_set_monitor_stream(s: ?*pa_stream, sink_input_idx: u32) c_int;
pub extern fn pa_stream_get_monitor_stream(s: ?*const pa_stream) u32;
pub extern fn pa_context_get_sink_info_by_name(c: ?*pa_context, name: [*c]const u8, cb: pa_sink_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_sink_info_by_index(c: ?*pa_context, idx: u32, cb: pa_sink_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_sink_info_list(c: ?*pa_context, cb: pa_sink_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_sink_volume_by_index(c: ?*pa_context, idx: u32, volume: [*c]const pa_cvolume, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_sink_volume_by_name(c: ?*pa_context, name: [*c]const u8, volume: [*c]const pa_cvolume, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_sink_mute_by_index(c: ?*pa_context, idx: u32, mute: c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_sink_mute_by_name(c: ?*pa_context, name: [*c]const u8, mute: c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_suspend_sink_by_name(c: ?*pa_context, sink_name: [*c]const u8, @"suspend": c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_suspend_sink_by_index(c: ?*pa_context, idx: u32, @"suspend": c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_sink_port_by_index(c: ?*pa_context, idx: u32, port: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_sink_port_by_name(c: ?*pa_context, name: [*c]const u8, port: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_source_info_by_name(c: ?*pa_context, name: [*c]const u8, cb: pa_source_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_source_info_by_index(c: ?*pa_context, idx: u32, cb: pa_source_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_source_info_list(c: ?*pa_context, cb: pa_source_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_source_volume_by_index(c: ?*pa_context, idx: u32, volume: [*c]const pa_cvolume, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_source_volume_by_name(c: ?*pa_context, name: [*c]const u8, volume: [*c]const pa_cvolume, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_source_mute_by_index(c: ?*pa_context, idx: u32, mute: c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_source_mute_by_name(c: ?*pa_context, name: [*c]const u8, mute: c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_suspend_source_by_name(c: ?*pa_context, source_name: [*c]const u8, @"suspend": c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_suspend_source_by_index(c: ?*pa_context, idx: u32, @"suspend": c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_source_port_by_index(c: ?*pa_context, idx: u32, port: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_source_port_by_name(c: ?*pa_context, name: [*c]const u8, port: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_server_info(c: ?*pa_context, cb: pa_server_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_module_info(c: ?*pa_context, idx: u32, cb: pa_module_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_module_info_list(c: ?*pa_context, cb: pa_module_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_load_module(c: ?*pa_context, name: [*c]const u8, argument: [*c]const u8, cb: pa_context_index_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_unload_module(c: ?*pa_context, idx: u32, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_send_message_to_object(c: ?*pa_context, recipient_name: [*c]const u8, message: [*c]const u8, message_parameters: [*c]const u8, cb: pa_context_string_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_client_info(c: ?*pa_context, idx: u32, cb: pa_client_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_client_info_list(c: ?*pa_context, cb: pa_client_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_kill_client(c: ?*pa_context, idx: u32, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_card_info_by_index(c: ?*pa_context, idx: u32, cb: pa_card_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_card_info_by_name(c: ?*pa_context, name: [*c]const u8, cb: pa_card_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_card_info_list(c: ?*pa_context, cb: pa_card_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_card_profile_by_index(c: ?*pa_context, idx: u32, profile: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_card_profile_by_name(c: ?*pa_context, name: [*c]const u8, profile: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_port_latency_offset(c: ?*pa_context, card_name: [*c]const u8, port_name: [*c]const u8, offset: i64, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_sink_input_info(c: ?*pa_context, idx: u32, cb: pa_sink_input_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_sink_input_info_list(c: ?*pa_context, cb: pa_sink_input_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_move_sink_input_by_name(c: ?*pa_context, idx: u32, sink_name: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_move_sink_input_by_index(c: ?*pa_context, idx: u32, sink_idx: u32, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_sink_input_volume(c: ?*pa_context, idx: u32, volume: [*c]const pa_cvolume, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_sink_input_mute(c: ?*pa_context, idx: u32, mute: c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_kill_sink_input(c: ?*pa_context, idx: u32, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_source_output_info(c: ?*pa_context, idx: u32, cb: pa_source_output_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_source_output_info_list(c: ?*pa_context, cb: pa_source_output_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_move_source_output_by_name(c: ?*pa_context, idx: u32, source_name: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_move_source_output_by_index(c: ?*pa_context, idx: u32, source_idx: u32, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_source_output_volume(c: ?*pa_context, idx: u32, volume: [*c]const pa_cvolume, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_source_output_mute(c: ?*pa_context, idx: u32, mute: c_int, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_kill_source_output(c: ?*pa_context, idx: u32, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_stat(c: ?*pa_context, cb: pa_stat_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_sample_info_by_name(c: ?*pa_context, name: [*c]const u8, cb: pa_sample_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_sample_info_by_index(c: ?*pa_context, idx: u32, cb: pa_sample_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_sample_info_list(c: ?*pa_context, cb: pa_sample_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_autoload_info_by_name(c: ?*pa_context, name: [*c]const u8, @"type": pa_autoload_type_t, cb: pa_autoload_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_autoload_info_by_index(c: ?*pa_context, idx: u32, cb: pa_autoload_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_get_autoload_info_list(c: ?*pa_context, cb: pa_autoload_info_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_add_autoload(c: ?*pa_context, name: [*c]const u8, @"type": pa_autoload_type_t, module: [*c]const u8, argument: [*c]const u8, pa_context_index_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_remove_autoload_by_name(c: ?*pa_context, name: [*c]const u8, @"type": pa_autoload_type_t, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_remove_autoload_by_index(c: ?*pa_context, idx: u32, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_subscribe(c: ?*pa_context, m: pa_subscription_mask_t, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_set_subscribe_callback(c: ?*pa_context, cb: pa_context_subscribe_cb_t, userdata: ?*anyopaque) void;
pub extern fn pa_stream_connect_upload(s: ?*pa_stream, length: usize) c_int;
pub extern fn pa_stream_finish_upload(s: ?*pa_stream) c_int;
pub extern fn pa_context_remove_sample(c: ?*pa_context, name: [*c]const u8, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_play_sample(c: ?*pa_context, name: [*c]const u8, dev: [*c]const u8, volume: pa_volume_t, cb: pa_context_success_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_context_play_sample_with_proplist(c: ?*pa_context, name: [*c]const u8, dev: [*c]const u8, volume: pa_volume_t, proplist: ?*const pa_proplist, cb: pa_context_play_sample_cb_t, userdata: ?*anyopaque) ?*pa_operation;
pub extern fn pa_strerror(@"error": c_int) [*c]const u8;
pub extern fn pa_xmalloc(l: usize) ?*anyopaque;
pub extern fn pa_xmalloc0(l: usize) ?*anyopaque;
pub extern fn pa_xrealloc(ptr: ?*anyopaque, size: usize) ?*anyopaque;
pub extern fn pa_xfree(p: ?*anyopaque) void;
pub extern fn pa_xstrdup(s: [*c]const u8) [*c]u8;
pub extern fn pa_xstrndup(s: [*c]const u8, l: usize) [*c]u8;
pub extern fn pa_xmemdup(p: ?*const anyopaque, l: usize) ?*anyopaque;
pub extern fn pa_utf8_valid(str: [*c]const u8) [*c]u8;
pub extern fn pa_ascii_valid(str: [*c]const u8) [*c]u8;
pub extern fn pa_utf8_filter(str: [*c]const u8) [*c]u8;
pub extern fn pa_ascii_filter(str: [*c]const u8) [*c]u8;
pub extern fn pa_utf8_to_locale(str: [*c]const u8) [*c]u8;
pub extern fn pa_locale_to_utf8(str: [*c]const u8) [*c]u8;
pub extern fn pa_threaded_mainloop_new() ?*pa_threaded_mainloop;
pub extern fn pa_threaded_mainloop_free(m: ?*pa_threaded_mainloop) void;
pub extern fn pa_threaded_mainloop_start(m: ?*pa_threaded_mainloop) c_int;
pub extern fn pa_threaded_mainloop_stop(m: ?*pa_threaded_mainloop) void;
pub extern fn pa_threaded_mainloop_lock(m: ?*pa_threaded_mainloop) void;
pub extern fn pa_threaded_mainloop_unlock(m: ?*pa_threaded_mainloop) void;
pub extern fn pa_threaded_mainloop_wait(m: ?*pa_threaded_mainloop) void;
pub extern fn pa_threaded_mainloop_signal(m: ?*pa_threaded_mainloop, wait_for_accept: c_int) void;
pub extern fn pa_threaded_mainloop_accept(m: ?*pa_threaded_mainloop) void;
pub extern fn pa_threaded_mainloop_get_retval(m: ?*const pa_threaded_mainloop) c_int;
pub extern fn pa_threaded_mainloop_get_api(m: ?*pa_threaded_mainloop) [*c]pa_mainloop_api;
pub extern fn pa_threaded_mainloop_in_thread(m: ?*pa_threaded_mainloop) c_int;
pub extern fn pa_threaded_mainloop_set_name(m: ?*pa_threaded_mainloop, name: [*c]const u8) void;
pub extern fn pa_threaded_mainloop_once_unlocked(m: ?*pa_threaded_mainloop, callback: ?*const fn (?*pa_threaded_mainloop, ?*anyopaque) callconv(.c) void, userdata: ?*anyopaque) void;
pub extern fn pa_mainloop_new() ?*pa_mainloop;
pub extern fn pa_mainloop_free(m: ?*pa_mainloop) void;
pub extern fn pa_mainloop_prepare(m: ?*pa_mainloop, timeout: c_int) c_int;
pub extern fn pa_mainloop_poll(m: ?*pa_mainloop) c_int;
pub extern fn pa_mainloop_dispatch(m: ?*pa_mainloop) c_int;
pub extern fn pa_mainloop_get_retval(m: ?*const pa_mainloop) c_int;
pub extern fn pa_mainloop_iterate(m: ?*pa_mainloop, block: c_int, retval: [*c]c_int) c_int;
pub extern fn pa_mainloop_run(m: ?*pa_mainloop, retval: [*c]c_int) c_int;
pub extern fn pa_mainloop_get_api(m: ?*pa_mainloop) [*c]pa_mainloop_api;
pub extern fn pa_mainloop_quit(m: ?*pa_mainloop, retval: c_int) void;
pub extern fn pa_mainloop_wakeup(m: ?*pa_mainloop) void;
pub extern fn pa_mainloop_set_poll_func(m: ?*pa_mainloop, poll_func: pa_poll_func, userdata: ?*anyopaque) void;
pub extern fn pa_signal_init(api: [*c]pa_mainloop_api) c_int;
pub extern fn pa_signal_done() void;
pub extern fn pa_signal_new(sig: c_int, callback: pa_signal_cb_t, userdata: ?*anyopaque) ?*pa_signal_event;
pub extern fn pa_signal_free(e: ?*pa_signal_event) void;
pub extern fn pa_signal_set_destroy(e: ?*pa_signal_event, callback: pa_signal_destroy_cb_t) void;
pub extern fn pa_get_user_name(s: [*c]u8, l: usize) [*c]u8;
pub extern fn pa_get_host_name(s: [*c]u8, l: usize) [*c]u8;
pub extern fn pa_get_fqdn(s: [*c]u8, l: usize) [*c]u8;
pub extern fn pa_get_home_dir(s: [*c]u8, l: usize) [*c]u8;
pub extern fn pa_get_binary_name(s: [*c]u8, l: usize) [*c]u8;
pub extern fn pa_path_get_filename(p: [*c]const u8) [*c]u8;
pub extern fn pa_msleep(t: c_ulong) c_int;
pub extern fn pa_thread_make_realtime(rtprio: c_int) c_int;
pub extern fn pa_gettimeofday(tv: [*c]std.c.timeval) [*c]std.c.timeval;
pub extern fn pa_timeval_diff(a: [*c]const std.c.timeval, b: [*c]const std.c.timeval) pa_usec_t;
pub extern fn pa_timeval_cmp(a: [*c]const std.c.timeval, b: [*c]const std.c.timeval) c_int;
pub extern fn pa_timeval_age(tv: [*c]const std.c.timeval) pa_usec_t;
pub extern fn pa_timeval_add(tv: [*c]std.c.timeval, v: pa_usec_t) [*c]std.c.timeval;
pub extern fn pa_timeval_sub(tv: [*c]std.c.timeval, v: pa_usec_t) [*c]std.c.timeval;
pub extern fn pa_timeval_store(tv: [*c]std.c.timeval, v: pa_usec_t) [*c]std.c.timeval;
pub extern fn pa_timeval_load(tv: [*c]const std.c.timeval) pa_usec_t;
pub extern fn pa_rtclock_now() pa_usec_t;
