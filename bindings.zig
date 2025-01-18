const std = @import("std");

pub const get_library_version = pa_get_library_version;
pub const sample_spec = extern struct {
    format: sample_format_t,
    rate: u32,
    channels: u8,
};
pub const sample_format_t = enum(c_int) {
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
pub const usec_t = u64;
pub const direction_t = enum(c_uint) {
    OUTPUT = 1,
    INPUT = 2,
};
pub const mainloop_api = extern struct {
    userdata: ?*anyopaque,
    io_new: ?*const fn ([*c]mainloop_api, c_int, io_event_flags_t, io_event_cb_t, ?*anyopaque) callconv(.c) ?*io_event,
    io_enable: ?*const fn (?*io_event, io_event_flags_t) callconv(.c) void,
    io_free: ?*const fn (?*io_event) callconv(.c) void,
    io_set_destroy: ?*const fn (?*io_event, io_event_destroy_cb_t) callconv(.c) void,
    time_new: ?*const fn ([*c]mainloop_api, [*c]const std.c.timeval, time_event_cb_t, ?*anyopaque) callconv(.c) ?*time_event,
    time_restart: ?*const fn (?*time_event, [*c]const std.c.timeval) callconv(.c) void,
    time_free: ?*const fn (?*time_event) callconv(.c) void,
    time_set_destroy: ?*const fn (?*time_event, time_event_destroy_cb_t) callconv(.c) void,
    defer_new: ?*const fn ([*c]mainloop_api, defer_event_cb_t, ?*anyopaque) callconv(.c) ?*defer_event,
    defer_enable: ?*const fn (?*defer_event, c_int) callconv(.c) void,
    defer_free: ?*const fn (?*defer_event) callconv(.c) void,
    defer_set_destroy: ?*const fn (?*defer_event, defer_event_destroy_cb_t) callconv(.c) void,
    quit: ?*const fn ([*c]mainloop_api, c_int) callconv(.c) void,
};
pub const io_event_cb_t = ?*const fn ([*c]mainloop_api, ?*io_event, c_int, io_event_flags_t, ?*anyopaque) callconv(.c) void;
pub const time_event_cb_t = ?*const fn ([*c]mainloop_api, ?*time_event, [*c]const std.c.timeval, ?*anyopaque) callconv(.c) void;
pub const io_event_destroy_cb_t = ?*const fn ([*c]mainloop_api, ?*io_event, ?*anyopaque) callconv(.c) void;
pub const time_event_destroy_cb_t = ?*const fn ([*c]mainloop_api, ?*time_event, ?*anyopaque) callconv(.c) void;
pub const defer_event_cb_t = ?*const fn ([*c]mainloop_api, ?*defer_event, ?*anyopaque) callconv(.c) void;
pub const defer_event_destroy_cb_t = ?*const fn ([*c]mainloop_api, ?*defer_event, ?*anyopaque) callconv(.c) void;
pub const operation_notify_cb_t = ?*const fn (?*operation, ?*anyopaque) callconv(.c) void;
pub const context_notify_cb_t = ?*const fn (?*context, ?*anyopaque) callconv(.c) void;
pub const context_event_cb_t = ?*const fn (?*context, [*c]const u8, ?*proplist, ?*anyopaque) callconv(.c) void;
pub const context_success_cb_t = ?*const fn (?*context, c_int, ?*anyopaque) callconv(.c) void;
pub const free_cb_t = ?*const fn (?*anyopaque) callconv(.c) void;
pub const stream_success_cb_t = ?*const fn (?*stream, c_int, ?*anyopaque) callconv(.c) void;
pub const stream_notify_cb_t = ?*const fn (?*stream, ?*anyopaque) callconv(.c) void;
pub const stream_request_cb_t = ?*const fn (?*stream, usize, ?*anyopaque) callconv(.c) void;
pub const stream_event_cb_t = ?*const fn (?*stream, [*c]const u8, ?*proplist, ?*anyopaque) callconv(.c) void;
pub const sink_info_cb_t = ?*const fn (?*context, [*c]const sink_info, c_int, ?*anyopaque) callconv(.c) void;
pub const source_info_cb_t = ?*const fn (?*context, [*c]const source_info, c_int, ?*anyopaque) callconv(.c) void;
pub const server_info_cb_t = ?*const fn (?*context, [*c]const server_info, ?*anyopaque) callconv(.c) void;
pub const module_info_cb_t = ?*const fn (?*context, [*c]const module_info, c_int, ?*anyopaque) callconv(.c) void;
pub const context_index_cb_t = ?*const fn (?*context, u32, ?*anyopaque) callconv(.c) void;
pub const context_string_cb_t = ?*const fn (?*context, c_int, [*c]u8, ?*anyopaque) callconv(.c) void;
pub const client_info_cb_t = ?*const fn (?*context, [*c]const client_info, c_int, ?*anyopaque) callconv(.c) void;
pub const card_info_cb_t = ?*const fn (?*context, [*c]const card_info, c_int, ?*anyopaque) callconv(.c) void;
pub const sink_input_info_cb_t = ?*const fn (?*context, [*c]const sink_input_info, c_int, ?*anyopaque) callconv(.c) void;
pub const source_output_info_cb_t = ?*const fn (?*context, [*c]const source_output_info, c_int, ?*anyopaque) callconv(.c) void;
pub const stat_info_cb_t = ?*const fn (?*context, [*c]const stat_info, ?*anyopaque) callconv(.c) void;
pub const sample_info_cb_t = ?*const fn (?*context, [*c]const sample_info, c_int, ?*anyopaque) callconv(.c) void;
pub const autoload_info_cb_t = ?*const fn (?*context, [*c]const autoload_info, c_int, ?*anyopaque) callconv(.c) void;
pub const signal_cb_t = ?*const fn ([*c]mainloop_api, ?*signal_event, c_int, ?*anyopaque) callconv(.c) void;
pub const context_subscribe_cb_t = ?*const fn (?*context, subscription_event_type_t, u32, ?*anyopaque) callconv(.c) void;
pub const context_play_sample_cb_t = ?*const fn (?*context, u32, ?*anyopaque) callconv(.c) void;
pub const signal_destroy_cb_t = ?*const fn ([*c]mainloop_api, ?*signal_event, ?*anyopaque) callconv(.c) void;

pub const io_event_flags_t = enum(c_uint) {
    NULL = 0,
    INPUT = 1,
    OUTPUT = 2,
    HANGUP = 4,
    ERROR = 8,
};
pub const io_event = opaque {};
pub const time_event = opaque {};
pub const defer_event = opaque {};
pub const proplist = opaque {
    pub const new = pa_proplist_new;
    extern fn pa_proplist_new() ?*proplist;
    pub const free = pa_proplist_free;
    extern fn pa_proplist_free(p: ?*proplist) void;
    pub const key_valid = pa_proplist_key_valid;
    extern fn pa_proplist_key_valid(key: [*:0]const u8) c_int;
    pub const sets = pa_proplist_sets;
    extern fn pa_proplist_sets(p: ?*proplist, key: [*:0]const u8, value: [*:0]const u8) c_int;
    pub const setp = pa_proplist_setp;
    extern fn pa_proplist_setp(p: ?*proplist, pair: [*:0]const u8) c_int;
    pub const setf = pa_proplist_setf;
    extern fn pa_proplist_setf(p: ?*proplist, key: [*:0]const u8, format: [*:0]const u8, ...) c_int;
    pub const set = pa_proplist_set;
    extern fn pa_proplist_set(p: ?*proplist, key: [*:0]const u8, data: ?*const anyopaque, nbytes: usize) c_int;
    pub const gets = pa_proplist_gets;
    extern fn pa_proplist_gets(p: ?*const proplist, key: [*:0]const u8) [*:0]const u8;
    pub const get = pa_proplist_get;
    extern fn pa_proplist_get(p: ?*const proplist, key: [*:0]const u8, data: [*c]?*const anyopaque, nbytes: [*c]usize) c_int;
    pub const update = pa_proplist_update;
    extern fn pa_proplist_update(p: ?*proplist, mode: update_mode_t, other: ?*const proplist) void;
    pub const unset = pa_proplist_unset;
    extern fn pa_proplist_unset(p: ?*proplist, key: [*:0]const u8) c_int;
    pub const unset_many = pa_proplist_unset_many;
    extern fn pa_proplist_unset_many(p: ?*proplist, keys: [*:null]const ?[*:0]const u8) c_int;
    pub const iterate = pa_proplist_iterate;
    extern fn pa_proplist_iterate(p: ?*const proplist, state: [*c]?*anyopaque) [*c]const u8;
    pub const to_string = pa_proplist_to_string;
    extern fn pa_proplist_to_string(p: ?*const proplist) [*:0]u8;
    pub const to_string_sep = pa_proplist_to_string_sep;
    extern fn pa_proplist_to_string_sep(p: ?*const proplist, sep: [*:0]const u8) [*:0]u8;
    pub const from_string = pa_proplist_from_string;
    extern fn pa_proplist_from_string(str: [*:0]const u8) ?*proplist;
    pub const contains = pa_proplist_contains;
    extern fn pa_proplist_contains(p: ?*const proplist, key: [*:0]const u8) c_int;
    pub const clear = pa_proplist_clear;
    extern fn pa_proplist_clear(p: ?*proplist) void;
    pub const copy = pa_proplist_copy;
    extern fn pa_proplist_copy(p: ?*const proplist) ?*proplist;
    pub const size = pa_proplist_size;
    extern fn pa_proplist_size(p: ?*const proplist) c_uint;
    pub const isempty = pa_proplist_isempty;
    extern fn pa_proplist_isempty(p: ?*const proplist) c_int;
    pub const equal = pa_proplist_equal;
    extern fn pa_proplist_equal(a: ?*const proplist, b: ?*const proplist) c_int;
};
pub const update_mode_t = enum(c_uint) {
    SET = 0,
    MERGE = 1,
    REPLACE = 2,
};
pub const channel_map = extern struct {
    channels: u8,
    map: [32]channel_position_t,
};
pub const channel_position_t = enum(c_int) {
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

pub const channel_map_def_t = enum(c_uint) {
    AIFF = 0,
    ALSA = 1,
    AUX = 2,
    WAVEEX = 3,
    OSS = 4,
    DEF_MAX = 5,
    DEFAULT = 0,
};
pub const channel_position_mask_t = u64;

pub const encoding_t = enum(c_int) {
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
pub const format_info = extern struct {
    encoding: encoding_t,
    plist: ?*proplist,
};
pub const prop_type_t = enum(c_int) {
    INT = 0,
    INT_RANGE = 1,
    INT_ARRAY = 2,
    STRING = 3,
    STRING_ARRAY = 4,
    INVALID = -1,
};
pub const operation = opaque {};
pub const operation_state_t = enum(c_uint) {
    RUNNING = 0,
    DONE = 1,
    CANCELLED = 2,
};
pub const context = opaque {};

pub const context_state_t = enum(c_uint) {
    UNCONNECTED = 0,
    CONNECTING = 1,
    AUTHORIZING = 2,
    SETTING_NAME = 3,
    READY = 4,
    FAILED = 5,
    TERMINATED = 6,
};

pub const context_flags_t = enum(c_uint) {
    NOFLAGS = 0,
    NOAUTOSPAWN = 1,
    NOFAIL = 2,
};

pub const spawn_api = extern struct {
    prefork: ?*const fn () callconv(.c) void,
    postfork: ?*const fn () callconv(.c) void,
    atfork: ?*const fn () callconv(.c) void,
};
pub const cvolume = extern struct {
    channels: u8,
    values: [32]volume_t,
};
pub const volume_t = u32;
pub const stream = opaque {};

pub const stream_state_t = enum(c_uint) {
    UNCONNECTED = 0,
    CREATING = 1,
    READY = 2,
    FAILED = 3,
    TERMINATED = 4,
};
pub const buffer_attr = extern struct {
    maxlength: u32,
    tlength: u32,
    prebuf: u32,
    minreq: u32,
    fragsize: u32,
};

pub const stream_flags_t = enum(c_uint) {
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

pub const seek_mode_t = enum(c_uint) {
    RELATIVE = 0,
    ABSOLUTE = 1,
    RELATIVE_ON_READ = 2,
    RELATIVE_END = 3,
};
pub const timing_info = extern struct {
    timestamp: std.c.timeval,
    synchronized_clocks: c_int,
    sink_usec: usec_t,
    source_usec: usec_t,
    transport_usec: usec_t,
    playing: c_int,
    write_index_corrupt: c_int,
    write_index: i64,
    read_index_corrupt: c_int,
    read_index: i64,
    configured_sink_usec: usec_t,
    configured_source_usec: usec_t,
    since_underrun: i64,
};
pub const sink_info = extern struct {
    name: [*c]const u8,
    index: u32,
    description: [*c]const u8,
    sample_spec: sample_spec,
    channel_map: channel_map,
    owner_module: u32,
    volume: cvolume,
    mute: c_int,
    monitor_source: u32,
    monitor_source_name: [*c]const u8,
    latency: usec_t,
    driver: [*c]const u8,
    flags: sink_flags_t,
    proplist: ?*proplist,
    configured_latency: usec_t,
    base_volume: volume_t,
    state: sink_state_t,
    n_volume_steps: u32,
    card: u32,
    n_ports: u32,
    ports: [*c][*c]sink_port_info,
    active_port: [*c]sink_port_info,
    n_formats: u8,
    formats: [*c][*c]format_info,
};

pub const sink_flags_t = enum(c_uint) {
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

pub const sink_state_t = enum(c_int) {
    INVALID_STATE = -1,
    RUNNING = 0,
    IDLE = 1,
    SUSPENDED = 2,
    INIT = -2,
    UNLINKED = -3,
};
pub const sink_port_info = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    priority: u32,
    available: c_int,
    availability_group: [*c]const u8,
    type: u32,
};
pub const source_info = extern struct {
    name: [*c]const u8,
    index: u32,
    description: [*c]const u8,
    sample_spec: sample_spec,
    channel_map: channel_map,
    owner_module: u32,
    volume: cvolume,
    mute: c_int,
    monitor_of_sink: u32,
    monitor_of_sink_name: [*c]const u8,
    latency: usec_t,
    driver: [*c]const u8,
    flags: source_flags_t,
    proplist: ?*proplist,
    configured_latency: usec_t,
    base_volume: volume_t,
    state: source_state_t,
    n_volume_steps: u32,
    card: u32,
    n_ports: u32,
    ports: [*c][*c]source_port_info,
    active_port: [*c]source_port_info,
    n_formats: u8,
    formats: [*c][*c]format_info,
};
pub const server_info = extern struct {
    user_name: [*c]const u8,
    host_name: [*c]const u8,
    server_version: [*c]const u8,
    server_name: [*c]const u8,
    sample_spec: sample_spec,
    default_sink_name: [*c]const u8,
    default_source_name: [*c]const u8,
    cookie: u32,
    channel_map: channel_map,
};
pub const module_info = extern struct {
    index: u32,
    name: [*c]const u8,
    argument: [*c]const u8,
    n_used: u32,
    auto_unload: c_int,
    proplist: ?*proplist,
};
pub const client_info = extern struct {
    index: u32,
    name: [*c]const u8,
    owner_module: u32,
    driver: [*c]const u8,
    proplist: ?*proplist,
};
pub const card_info = extern struct {
    index: u32,
    name: [*c]const u8,
    owner_module: u32,
    driver: [*c]const u8,
    n_profiles: u32,
    profiles: [*c]card_profile_info,
    active_profile: [*c]card_profile_info,
    proplist: ?*proplist,
    n_ports: u32,
    ports: [*c][*c]card_port_info,
    profiles2: [*c][*c]card_profile_info2,
    active_profile2: [*c]card_profile_info2,
};
pub const sink_input_info = extern struct {
    index: u32,
    name: [*c]const u8,
    owner_module: u32,
    client: u32,
    sink: u32,
    sample_spec: sample_spec,
    channel_map: channel_map,
    volume: cvolume,
    buffer_usec: usec_t,
    sink_usec: usec_t,
    resample_method: [*c]const u8,
    driver: [*c]const u8,
    mute: c_int,
    proplist: ?*proplist,
    corked: c_int,
    has_volume: c_int,
    volume_writable: c_int,
    format: [*c]format_info,
};
pub const source_output_info = extern struct {
    index: u32,
    name: [*c]const u8,
    owner_module: u32,
    client: u32,
    source: u32,
    sample_spec: sample_spec,
    channel_map: channel_map,
    buffer_usec: usec_t,
    source_usec: usec_t,
    resample_method: [*c]const u8,
    driver: [*c]const u8,
    proplist: ?*proplist,
    corked: c_int,
    volume: cvolume,
    mute: c_int,
    has_volume: c_int,
    volume_writable: c_int,
    format: [*c]format_info,
};
pub const stat_info = extern struct {
    memblock_total: u32,
    memblock_total_size: u32,
    memblock_allocated: u32,
    memblock_allocated_size: u32,
    scache_size: u32,
};
pub const sample_info = extern struct {
    index: u32,
    name: [*c]const u8,
    volume: cvolume,
    sample_spec: sample_spec,
    channel_map: channel_map,
    duration: usec_t,
    bytes: u32,
    lazy: c_int,
    filename: [*c]const u8,
    proplist: ?*proplist,
};
pub const autoload_info = extern struct {
    index: u32,
    name: [*c]const u8,
    type: autoload_type_t,
    module: [*c]const u8,
    argument: [*c]const u8,
};
pub const signal_event = opaque {};
pub const source_flags_t = enum(c_uint) {
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

pub const source_state_t = enum(c_int) {
    INVALID_STATE = -1,
    RUNNING = 0,
    IDLE = 1,
    SUSPENDED = 2,
    INIT = -2,
    UNLINKED = -3,
};
pub const source_port_info = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    priority: u32,
    available: c_int,
    availability_group: [*c]const u8,
    type: u32,
};
pub const card_profile_info = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    n_sinks: u32,
    n_sources: u32,
    priority: u32,
};
pub const threaded_mainloop = opaque {
    pub const new = pa_threaded_mainloop_new;
    extern fn pa_threaded_mainloop_new() ?*threaded_mainloop;
    pub const free = pa_threaded_mainloop_free;
    extern fn pa_threaded_mainloop_free(m: *threaded_mainloop) void;
    pub const start = pa_threaded_mainloop_start;
    extern fn pa_threaded_mainloop_start(m: *threaded_mainloop) c_int;
    pub const stop = pa_threaded_mainloop_stop;
    extern fn pa_threaded_mainloop_stop(m: *threaded_mainloop) void;
    pub const lock = pa_threaded_mainloop_lock;
    extern fn pa_threaded_mainloop_lock(m: *threaded_mainloop) void;
    pub const unlock = pa_threaded_mainloop_unlock;
    extern fn pa_threaded_mainloop_unlock(m: *threaded_mainloop) void;
    pub const wait = pa_threaded_mainloop_wait;
    extern fn pa_threaded_mainloop_wait(m: *threaded_mainloop) void;
    pub const signal = pa_threaded_mainloop_signal;
    extern fn pa_threaded_mainloop_signal(m: *threaded_mainloop, wait_for_accept: c_int) void;
    pub const accept = pa_threaded_mainloop_accept;
    extern fn pa_threaded_mainloop_accept(m: *threaded_mainloop) void;
    pub const get_retval = pa_threaded_mainloop_get_retval;
    extern fn pa_threaded_mainloop_get_retval(m: *const threaded_mainloop) c_int;
    pub const get_api = pa_threaded_mainloop_get_api;
    extern fn pa_threaded_mainloop_get_api(m: *threaded_mainloop) *mainloop_api;
    pub const in_thread = pa_threaded_mainloop_in_thread;
    extern fn pa_threaded_mainloop_in_thread(m: *threaded_mainloop) c_int;
    pub const set_name = pa_threaded_mainloop_set_name;
    extern fn pa_threaded_mainloop_set_name(m: *threaded_mainloop, name: [*:0]const u8) void;
    pub const once_unlocked = pa_threaded_mainloop_once_unlocked;
    extern fn pa_threaded_mainloop_once_unlocked(m: *threaded_mainloop, callback: *const fn (*threaded_mainloop, ?*anyopaque) callconv(.c) void, userdata: ?*anyopaque) void;
};
pub const card_port_info = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    priority: u32,
    available: c_int,
    direction: c_int,
    n_profiles: u32,
    profiles: [*c][*c]card_profile_info,
    proplist: ?*proplist,
    latency_offset: i64,
    profiles2: [*c][*c]card_profile_info2,
    availability_group: [*c]const u8,
    type: u32,
};
pub const card_profile_info2 = extern struct {
    name: [*c]const u8,
    description: [*c]const u8,
    n_sinks: u32,
    n_sources: u32,
    priority: u32,
    available: c_int,
};
pub const autoload_type_t = enum(c_uint) {
    SINK = 0,
    SOURCE = 1,
};
pub const subscription_mask_t = enum(c_uint) {
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
pub const mainloop = opaque {};
pub const subscription_event_type_t = enum(c_uint) {
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
pub const poll_func = ?*const fn (?*std.c.pollfd, c_ulong, c_int, ?*anyopaque) callconv(.c) c_int;

extern fn pa_get_library_version() [*:0]const u8;
extern fn pa_bytes_per_second(spec: [*c]const sample_spec) usize;
extern fn pa_frame_size(spec: [*c]const sample_spec) usize;
extern fn pa_sample_size(spec: [*c]const sample_spec) usize;
extern fn pa_sample_size_of_format(f: sample_format_t) usize;
extern fn pa_bytes_to_usec(length: u64, spec: [*c]const sample_spec) usec_t;
extern fn pa_usec_to_bytes(t: usec_t, spec: [*c]const sample_spec) usize;
extern fn pa_sample_spec_init(spec: [*c]sample_spec) [*c]sample_spec;
extern fn pa_sample_format_valid(format: c_uint) c_int;
extern fn pa_sample_rate_valid(rate: u32) c_int;
extern fn pa_channels_valid(channels: u8) c_int;
extern fn pa_sample_spec_valid(spec: [*c]const sample_spec) c_int;
extern fn pa_sample_spec_equal(a: [*c]const sample_spec, b: [*c]const sample_spec) c_int;
extern fn pa_sample_format_to_string(f: sample_format_t) [*c]const u8;
extern fn pa_parse_sample_format(format: [*c]const u8) sample_format_t;
extern fn pa_sample_spec_snprint(s: [*c]u8, l: usize, spec: [*c]const sample_spec) [*c]u8;
extern fn pa_bytes_snprint(s: [*c]u8, l: usize, v: c_uint) [*c]u8;
extern fn pa_sample_format_is_le(f: sample_format_t) c_int;
extern fn pa_sample_format_is_be(f: sample_format_t) c_int;
extern fn pa_direction_valid(direction: direction_t) c_int;
extern fn pa_direction_to_string(direction: direction_t) [*c]const u8;
extern fn pa_mainloop_api_once(m: [*c]mainloop_api, callback: ?*const fn ([*c]mainloop_api, ?*anyopaque) callconv(.c) void, userdata: ?*anyopaque) void;
extern fn pa_channel_map_init(m: [*c]channel_map) [*c]channel_map;
extern fn pa_channel_map_init_mono(m: [*c]channel_map) [*c]channel_map;
extern fn pa_channel_map_init_stereo(m: [*c]channel_map) [*c]channel_map;
extern fn pa_channel_map_init_auto(m: [*c]channel_map, channels: c_uint, def: channel_map_def_t) [*c]channel_map;
extern fn pa_channel_map_init_extend(m: [*c]channel_map, channels: c_uint, def: channel_map_def_t) [*c]channel_map;
extern fn pa_channel_position_to_string(pos: channel_position_t) [*c]const u8;
extern fn pa_channel_position_from_string(s: [*c]const u8) channel_position_t;
extern fn pa_channel_position_to_pretty_string(pos: channel_position_t) [*c]const u8;
extern fn pa_channel_map_snprint(s: [*c]u8, l: usize, map: [*c]const channel_map) [*c]u8;
extern fn pa_channel_map_parse(map: [*c]channel_map, s: [*c]const u8) [*c]channel_map;
extern fn pa_channel_map_equal(a: [*c]const channel_map, b: [*c]const channel_map) c_int;
extern fn pa_channel_map_valid(map: [*c]const channel_map) c_int;
extern fn pa_channel_map_compatible(map: [*c]const channel_map, ss: [*c]const sample_spec) c_int;
extern fn pa_channel_map_superset(a: [*c]const channel_map, b: [*c]const channel_map) c_int;
extern fn pa_channel_map_can_balance(map: [*c]const channel_map) c_int;
extern fn pa_channel_map_can_fade(map: [*c]const channel_map) c_int;
extern fn pa_channel_map_can_lfe_balance(map: [*c]const channel_map) c_int;
extern fn pa_channel_map_to_name(map: [*c]const channel_map) [*c]const u8;
extern fn pa_channel_map_to_pretty_name(map: [*c]const channel_map) [*c]const u8;
extern fn pa_channel_map_has_position(map: [*c]const channel_map, p: channel_position_t) c_int;
extern fn pa_channel_map_mask(map: [*c]const channel_map) channel_position_mask_t;
extern fn pa_encoding_to_string(e: encoding_t) [*c]const u8;
extern fn pa_encoding_from_string(encoding: [*c]const u8) encoding_t;
extern fn pa_format_info_new() [*c]format_info;
extern fn pa_format_info_copy(src: [*c]const format_info) [*c]format_info;
extern fn pa_format_info_free(f: [*c]format_info) void;
extern fn pa_format_info_valid(f: [*c]const format_info) c_int;
extern fn pa_format_info_is_pcm(f: [*c]const format_info) c_int;
extern fn pa_format_info_is_compatible(first: [*c]const format_info, second: [*c]const format_info) c_int;
extern fn pa_format_info_snprint(s: [*c]u8, l: usize, f: [*c]const format_info) [*c]u8;
extern fn pa_format_info_from_string(str: [*c]const u8) [*c]format_info;
extern fn pa_format_info_from_sample_spec(ss: [*c]const sample_spec, map: [*c]const channel_map) [*c]format_info;
extern fn pa_format_info_to_sample_spec(f: [*c]const format_info, ss: [*c]sample_spec, map: [*c]channel_map) c_int;
extern fn pa_format_info_get_prop_type(f: [*c]const format_info, key: [*c]const u8) prop_type_t;
extern fn pa_format_info_get_prop_int(f: [*c]const format_info, key: [*c]const u8, v: [*c]c_int) c_int;
extern fn pa_format_info_get_prop_int_range(f: [*c]const format_info, key: [*c]const u8, min: [*c]c_int, max: [*c]c_int) c_int;
extern fn pa_format_info_get_prop_int_array(f: [*c]const format_info, key: [*c]const u8, values: [*c][*c]c_int, n_values: [*c]c_int) c_int;
extern fn pa_format_info_get_prop_string(f: [*c]const format_info, key: [*c]const u8, v: [*c][*c]u8) c_int;
extern fn pa_format_info_get_prop_string_array(f: [*c]const format_info, key: [*c]const u8, values: [*c][*c][*c]u8, n_values: [*c]c_int) c_int;
extern fn pa_format_info_free_string_array(values: [*c][*c]u8, n_values: c_int) void;
extern fn pa_format_info_get_sample_format(f: [*c]const format_info, sf: [*c]sample_format_t) c_int;
extern fn pa_format_info_get_rate(f: [*c]const format_info, rate: [*c]u32) c_int;
extern fn pa_format_info_get_channels(f: [*c]const format_info, channels: [*c]u8) c_int;
extern fn pa_format_info_get_channel_map(f: [*c]const format_info, map: [*c]channel_map) c_int;
extern fn pa_format_info_set_prop_int(f: [*c]format_info, key: [*c]const u8, value: c_int) void;
extern fn pa_format_info_set_prop_int_array(f: [*c]format_info, key: [*c]const u8, values: [*c]const c_int, n_values: c_int) void;
extern fn pa_format_info_set_prop_int_range(f: [*c]format_info, key: [*c]const u8, min: c_int, max: c_int) void;
extern fn pa_format_info_set_prop_string(f: [*c]format_info, key: [*c]const u8, value: [*c]const u8) void;
extern fn pa_format_info_set_prop_string_array(f: [*c]format_info, key: [*c]const u8, values: [*c][*c]const u8, n_values: c_int) void;
extern fn pa_format_info_set_sample_format(f: [*c]format_info, sf: sample_format_t) void;
extern fn pa_format_info_set_rate(f: [*c]format_info, rate: c_int) void;
extern fn pa_format_info_set_channels(f: [*c]format_info, channels: c_int) void;
extern fn pa_format_info_set_channel_map(f: [*c]format_info, map: [*c]const channel_map) void;
extern fn pa_operation_ref(o: ?*operation) ?*operation;
extern fn pa_operation_unref(o: ?*operation) void;
extern fn pa_operation_cancel(o: ?*operation) void;
extern fn pa_operation_get_state(o: ?*const operation) operation_state_t;
extern fn pa_operation_set_state_callback(o: ?*operation, cb: operation_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_context_new(mainloop: [*c]mainloop_api, name: [*c]const u8) ?*context;
extern fn pa_context_new_with_proplist(mainloop: [*c]mainloop_api, name: [*c]const u8, proplist: ?*const proplist) ?*context;
extern fn pa_context_unref(c: ?*context) void;
extern fn pa_context_ref(c: ?*context) ?*context;
extern fn pa_context_set_state_callback(c: ?*context, cb: context_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_context_set_event_callback(p: ?*context, cb: context_event_cb_t, userdata: ?*anyopaque) void;
extern fn pa_context_errno(c: ?*const context) c_int;
extern fn pa_context_is_pending(c: ?*const context) c_int;
extern fn pa_context_get_state(c: ?*const context) context_state_t;
extern fn pa_context_connect(c: ?*context, server: [*c]const u8, flags: context_flags_t, api: [*c]const spawn_api) c_int;
extern fn pa_context_disconnect(c: ?*context) void;
extern fn pa_context_drain(c: ?*context, cb: context_notify_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_exit_daemon(c: ?*context, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_default_sink(c: ?*context, name: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_default_source(c: ?*context, name: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_is_local(c: ?*const context) c_int;
extern fn pa_context_set_name(c: ?*context, name: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_server(c: ?*const context) [*c]const u8;
extern fn pa_context_get_protocol_version(c: ?*const context) u32;
extern fn pa_context_get_server_protocol_version(c: ?*const context) u32;
extern fn pa_context_proplist_update(c: ?*context, mode: update_mode_t, p: ?*const proplist, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_proplist_remove(c: ?*context, keys: [*c]const [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_index(s: ?*const context) u32;
extern fn pa_context_rttime_new(c: ?*const context, usec: usec_t, cb: time_event_cb_t, userdata: ?*anyopaque) ?*time_event;
extern fn pa_context_rttime_restart(c: ?*const context, e: ?*time_event, usec: usec_t) void;
extern fn pa_context_get_tile_size(c: ?*const context, ss: [*c]const sample_spec) usize;
extern fn pa_context_load_cookie_from_file(c: ?*context, cookie_file_path: [*c]const u8) c_int;
extern fn pa_cvolume_equal(a: [*c]const cvolume, b: [*c]const cvolume) c_int;
extern fn pa_cvolume_init(a: [*c]cvolume) [*c]cvolume;
extern fn pa_cvolume_set(a: [*c]cvolume, channels: c_uint, v: volume_t) [*c]cvolume;
extern fn pa_cvolume_snprint(s: [*c]u8, l: usize, c: [*c]const cvolume) [*c]u8;
extern fn pa_sw_cvolume_snprint_dB(s: [*c]u8, l: usize, c: [*c]const cvolume) [*c]u8;
extern fn pa_cvolume_snprint_verbose(s: [*c]u8, l: usize, c: [*c]const cvolume, map: [*c]const channel_map, print_dB: c_int) [*c]u8;
extern fn pa_volume_snprint(s: [*c]u8, l: usize, v: volume_t) [*c]u8;
extern fn pa_sw_volume_snprint_dB(s: [*c]u8, l: usize, v: volume_t) [*c]u8;
extern fn pa_volume_snprint_verbose(s: [*c]u8, l: usize, v: volume_t, print_dB: c_int) [*c]u8;
extern fn pa_cvolume_avg(a: [*c]const cvolume) volume_t;
extern fn pa_cvolume_avg_mask(a: [*c]const cvolume, cm: [*c]const channel_map, mask: channel_position_mask_t) volume_t;
extern fn pa_cvolume_max(a: [*c]const cvolume) volume_t;
extern fn pa_cvolume_max_mask(a: [*c]const cvolume, cm: [*c]const channel_map, mask: channel_position_mask_t) volume_t;
extern fn pa_cvolume_min(a: [*c]const cvolume) volume_t;
extern fn pa_cvolume_min_mask(a: [*c]const cvolume, cm: [*c]const channel_map, mask: channel_position_mask_t) volume_t;
extern fn pa_cvolume_valid(v: [*c]const cvolume) c_int;
extern fn pa_cvolume_channels_equal_to(a: [*c]const cvolume, v: volume_t) c_int;
extern fn pa_sw_volume_multiply(a: volume_t, b: volume_t) volume_t;
extern fn pa_sw_cvolume_multiply(dest: [*c]cvolume, a: [*c]const cvolume, b: [*c]const cvolume) [*c]cvolume;
extern fn pa_sw_cvolume_multiply_scalar(dest: [*c]cvolume, a: [*c]const cvolume, b: volume_t) [*c]cvolume;
extern fn pa_sw_volume_divide(a: volume_t, b: volume_t) volume_t;
extern fn pa_sw_cvolume_divide(dest: [*c]cvolume, a: [*c]const cvolume, b: [*c]const cvolume) [*c]cvolume;
extern fn pa_sw_cvolume_divide_scalar(dest: [*c]cvolume, a: [*c]const cvolume, b: volume_t) [*c]cvolume;
extern fn pa_sw_volume_from_dB(f: f64) volume_t;
extern fn pa_sw_volume_to_dB(v: volume_t) f64;
extern fn pa_sw_volume_from_linear(v: f64) volume_t;
extern fn pa_sw_volume_to_linear(v: volume_t) f64;
extern fn pa_cvolume_remap(v: [*c]cvolume, from: [*c]const channel_map, to: [*c]const channel_map) [*c]cvolume;
extern fn pa_cvolume_compatible(v: [*c]const cvolume, ss: [*c]const sample_spec) c_int;
extern fn pa_cvolume_compatible_with_channel_map(v: [*c]const cvolume, cm: [*c]const channel_map) c_int;
extern fn pa_cvolume_get_balance(v: [*c]const cvolume, map: [*c]const channel_map) f32;
extern fn pa_cvolume_set_balance(v: [*c]cvolume, map: [*c]const channel_map, new_balance: f32) [*c]cvolume;
extern fn pa_cvolume_get_fade(v: [*c]const cvolume, map: [*c]const channel_map) f32;
extern fn pa_cvolume_set_fade(v: [*c]cvolume, map: [*c]const channel_map, new_fade: f32) [*c]cvolume;
extern fn pa_cvolume_get_lfe_balance(v: [*c]const cvolume, map: [*c]const channel_map) f32;
extern fn pa_cvolume_set_lfe_balance(v: [*c]cvolume, map: [*c]const channel_map, new_balance: f32) [*c]cvolume;
extern fn pa_cvolume_scale(v: [*c]cvolume, max: volume_t) [*c]cvolume;
extern fn pa_cvolume_scale_mask(v: [*c]cvolume, max: volume_t, cm: [*c]const channel_map, mask: channel_position_mask_t) [*c]cvolume;
extern fn pa_cvolume_set_position(cv: [*c]cvolume, map: [*c]const channel_map, t: channel_position_t, v: volume_t) [*c]cvolume;
extern fn pa_cvolume_get_position(cv: [*c]const cvolume, map: [*c]const channel_map, t: channel_position_t) volume_t;
extern fn pa_cvolume_merge(dest: [*c]cvolume, a: [*c]const cvolume, b: [*c]const cvolume) [*c]cvolume;
extern fn pa_cvolume_inc_clamp(v: [*c]cvolume, inc: volume_t, limit: volume_t) [*c]cvolume;
extern fn pa_cvolume_inc(v: [*c]cvolume, inc: volume_t) [*c]cvolume;
extern fn pa_cvolume_dec(v: [*c]cvolume, dec: volume_t) [*c]cvolume;
extern fn pa_stream_new(c: ?*context, name: [*c]const u8, ss: [*c]const sample_spec, map: [*c]const channel_map) ?*stream;
extern fn pa_stream_new_with_proplist(c: ?*context, name: [*c]const u8, ss: [*c]const sample_spec, map: [*c]const channel_map, p: ?*proplist) ?*stream;
extern fn pa_stream_new_extended(c: ?*context, name: [*c]const u8, formats: [*c]const [*c]format_info, n_formats: c_uint, p: ?*proplist) ?*stream;
extern fn pa_stream_unref(s: ?*stream) void;
extern fn pa_stream_ref(s: ?*stream) ?*stream;
extern fn pa_stream_get_state(p: ?*const stream) stream_state_t;
extern fn pa_stream_get_context(p: ?*const stream) ?*context;
extern fn pa_stream_get_index(s: ?*const stream) u32;
extern fn pa_stream_get_device_index(s: ?*const stream) u32;
extern fn pa_stream_get_device_name(s: ?*const stream) [*c]const u8;
extern fn pa_stream_is_suspended(s: ?*const stream) c_int;
extern fn pa_stream_is_corked(s: ?*const stream) c_int;
extern fn pa_stream_connect_playback(s: ?*stream, dev: [*c]const u8, attr: [*c]const buffer_attr, flags: stream_flags_t, volume: [*c]const cvolume, sync_stream: ?*stream) c_int;
extern fn pa_stream_connect_record(s: ?*stream, dev: [*c]const u8, attr: [*c]const buffer_attr, flags: stream_flags_t) c_int;
extern fn pa_stream_disconnect(s: ?*stream) c_int;
extern fn pa_stream_begin_write(p: ?*stream, data: [*c]?*anyopaque, nbytes: [*c]usize) c_int;
extern fn pa_stream_cancel_write(p: ?*stream) c_int;
extern fn pa_stream_write(p: ?*stream, data: ?*const anyopaque, nbytes: usize, free_cb: free_cb_t, offset: i64, seek: seek_mode_t) c_int;
extern fn pa_stream_write_ext_free(p: ?*stream, data: ?*const anyopaque, nbytes: usize, free_cb: free_cb_t, free_cb_data: ?*anyopaque, offset: i64, seek: seek_mode_t) c_int;
extern fn pa_stream_peek(p: ?*stream, data: [*c]?*const anyopaque, nbytes: [*c]usize) c_int;
extern fn pa_stream_drop(p: ?*stream) c_int;
extern fn pa_stream_writable_size(p: ?*const stream) usize;
extern fn pa_stream_readable_size(p: ?*const stream) usize;
extern fn pa_stream_drain(s: ?*stream, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_update_timing_info(p: ?*stream, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_set_state_callback(s: ?*stream, cb: stream_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_write_callback(p: ?*stream, cb: stream_request_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_read_callback(p: ?*stream, cb: stream_request_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_overflow_callback(p: ?*stream, cb: stream_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_get_underflow_index(p: ?*const stream) i64;
extern fn pa_stream_set_underflow_callback(p: ?*stream, cb: stream_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_started_callback(p: ?*stream, cb: stream_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_latency_update_callback(p: ?*stream, cb: stream_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_moved_callback(p: ?*stream, cb: stream_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_suspended_callback(p: ?*stream, cb: stream_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_event_callback(p: ?*stream, cb: stream_event_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_set_buffer_attr_callback(p: ?*stream, cb: stream_notify_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_cork(s: ?*stream, b: c_int, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_flush(s: ?*stream, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_prebuf(s: ?*stream, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_trigger(s: ?*stream, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_set_name(s: ?*stream, name: [*c]const u8, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_get_time(s: ?*stream, r_usec: [*c]usec_t) c_int;
extern fn pa_stream_get_latency(s: ?*stream, r_usec: [*c]usec_t, negative: [*c]c_int) c_int;
extern fn pa_stream_get_timing_info(s: ?*stream) [*c]const timing_info;
extern fn pa_stream_get_sample_spec(s: ?*stream) [*c]const sample_spec;
extern fn pa_stream_get_channel_map(s: ?*stream) [*c]const channel_map;
extern fn pa_stream_get_format_info(s: ?*const stream) [*c]const format_info;
extern fn pa_stream_get_buffer_attr(s: ?*stream) [*c]const buffer_attr;
extern fn pa_stream_set_buffer_attr(s: ?*stream, attr: [*c]const buffer_attr, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_update_sample_rate(s: ?*stream, rate: u32, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_proplist_update(s: ?*stream, mode: update_mode_t, p: ?*proplist, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_proplist_remove(s: ?*stream, keys: [*c]const [*c]const u8, cb: stream_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_stream_set_monitor_stream(s: ?*stream, sink_input_idx: u32) c_int;
extern fn pa_stream_get_monitor_stream(s: ?*const stream) u32;
extern fn pa_context_get_sink_info_by_name(c: ?*context, name: [*c]const u8, cb: sink_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_sink_info_by_index(c: ?*context, idx: u32, cb: sink_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_sink_info_list(c: ?*context, cb: sink_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_sink_volume_by_index(c: ?*context, idx: u32, volume: [*c]const cvolume, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_sink_volume_by_name(c: ?*context, name: [*c]const u8, volume: [*c]const cvolume, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_sink_mute_by_index(c: ?*context, idx: u32, mute: c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_sink_mute_by_name(c: ?*context, name: [*c]const u8, mute: c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_suspend_sink_by_name(c: ?*context, sink_name: [*c]const u8, @"suspend": c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_suspend_sink_by_index(c: ?*context, idx: u32, @"suspend": c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_sink_port_by_index(c: ?*context, idx: u32, port: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_sink_port_by_name(c: ?*context, name: [*c]const u8, port: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_source_info_by_name(c: ?*context, name: [*c]const u8, cb: source_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_source_info_by_index(c: ?*context, idx: u32, cb: source_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_source_info_list(c: ?*context, cb: source_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_source_volume_by_index(c: ?*context, idx: u32, volume: [*c]const cvolume, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_source_volume_by_name(c: ?*context, name: [*c]const u8, volume: [*c]const cvolume, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_source_mute_by_index(c: ?*context, idx: u32, mute: c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_source_mute_by_name(c: ?*context, name: [*c]const u8, mute: c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_suspend_source_by_name(c: ?*context, source_name: [*c]const u8, @"suspend": c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_suspend_source_by_index(c: ?*context, idx: u32, @"suspend": c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_source_port_by_index(c: ?*context, idx: u32, port: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_source_port_by_name(c: ?*context, name: [*c]const u8, port: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_server_info(c: ?*context, cb: server_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_module_info(c: ?*context, idx: u32, cb: module_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_module_info_list(c: ?*context, cb: module_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_load_module(c: ?*context, name: [*c]const u8, argument: [*c]const u8, cb: context_index_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_unload_module(c: ?*context, idx: u32, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_send_message_to_object(c: ?*context, recipient_name: [*c]const u8, message: [*c]const u8, message_parameters: [*c]const u8, cb: context_string_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_client_info(c: ?*context, idx: u32, cb: client_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_client_info_list(c: ?*context, cb: client_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_kill_client(c: ?*context, idx: u32, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_card_info_by_index(c: ?*context, idx: u32, cb: card_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_card_info_by_name(c: ?*context, name: [*c]const u8, cb: card_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_card_info_list(c: ?*context, cb: card_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_card_profile_by_index(c: ?*context, idx: u32, profile: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_card_profile_by_name(c: ?*context, name: [*c]const u8, profile: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_port_latency_offset(c: ?*context, card_name: [*c]const u8, port_name: [*c]const u8, offset: i64, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_sink_input_info(c: ?*context, idx: u32, cb: sink_input_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_sink_input_info_list(c: ?*context, cb: sink_input_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_move_sink_input_by_name(c: ?*context, idx: u32, sink_name: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_move_sink_input_by_index(c: ?*context, idx: u32, sink_idx: u32, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_sink_input_volume(c: ?*context, idx: u32, volume: [*c]const cvolume, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_sink_input_mute(c: ?*context, idx: u32, mute: c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_kill_sink_input(c: ?*context, idx: u32, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_source_output_info(c: ?*context, idx: u32, cb: source_output_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_source_output_info_list(c: ?*context, cb: source_output_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_move_source_output_by_name(c: ?*context, idx: u32, source_name: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_move_source_output_by_index(c: ?*context, idx: u32, source_idx: u32, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_source_output_volume(c: ?*context, idx: u32, volume: [*c]const cvolume, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_source_output_mute(c: ?*context, idx: u32, mute: c_int, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_kill_source_output(c: ?*context, idx: u32, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_stat(c: ?*context, cb: stat_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_sample_info_by_name(c: ?*context, name: [*c]const u8, cb: sample_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_sample_info_by_index(c: ?*context, idx: u32, cb: sample_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_sample_info_list(c: ?*context, cb: sample_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_autoload_info_by_name(c: ?*context, name: [*c]const u8, @"type": autoload_type_t, cb: autoload_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_autoload_info_by_index(c: ?*context, idx: u32, cb: autoload_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_get_autoload_info_list(c: ?*context, cb: autoload_info_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_add_autoload(c: ?*context, name: [*c]const u8, @"type": autoload_type_t, module: [*c]const u8, argument: [*c]const u8, context_index_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_remove_autoload_by_name(c: ?*context, name: [*c]const u8, @"type": autoload_type_t, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_remove_autoload_by_index(c: ?*context, idx: u32, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_subscribe(c: ?*context, m: subscription_mask_t, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_set_subscribe_callback(c: ?*context, cb: context_subscribe_cb_t, userdata: ?*anyopaque) void;
extern fn pa_stream_connect_upload(s: ?*stream, length: usize) c_int;
extern fn pa_stream_finish_upload(s: ?*stream) c_int;
extern fn pa_context_remove_sample(c: ?*context, name: [*c]const u8, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_play_sample(c: ?*context, name: [*c]const u8, dev: [*c]const u8, volume: volume_t, cb: context_success_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_context_play_sample_with_proplist(c: ?*context, name: [*c]const u8, dev: [*c]const u8, volume: volume_t, proplist: ?*const proplist, cb: context_play_sample_cb_t, userdata: ?*anyopaque) ?*operation;
extern fn pa_strerror(@"error": c_int) [*c]const u8;
extern fn pa_xmalloc(l: usize) ?*anyopaque;
extern fn pa_xmalloc0(l: usize) ?*anyopaque;
extern fn pa_xrealloc(ptr: ?*anyopaque, size: usize) ?*anyopaque;
extern fn pa_xfree(p: ?*anyopaque) void;
extern fn pa_xstrdup(s: [*c]const u8) [*c]u8;
extern fn pa_xstrndup(s: [*c]const u8, l: usize) [*c]u8;
extern fn pa_xmemdup(p: ?*const anyopaque, l: usize) ?*anyopaque;
extern fn pa_utf8_valid(str: [*c]const u8) [*c]u8;
extern fn pa_ascii_valid(str: [*c]const u8) [*c]u8;
extern fn pa_utf8_filter(str: [*c]const u8) [*c]u8;
extern fn pa_ascii_filter(str: [*c]const u8) [*c]u8;
extern fn pa_utf8_to_locale(str: [*c]const u8) [*c]u8;
extern fn pa_locale_to_utf8(str: [*c]const u8) [*c]u8;
extern fn pa_mainloop_new() ?*mainloop;
extern fn pa_mainloop_free(m: ?*mainloop) void;
extern fn pa_mainloop_prepare(m: ?*mainloop, timeout: c_int) c_int;
extern fn pa_mainloop_poll(m: ?*mainloop) c_int;
extern fn pa_mainloop_dispatch(m: ?*mainloop) c_int;
extern fn pa_mainloop_get_retval(m: ?*const mainloop) c_int;
extern fn pa_mainloop_iterate(m: ?*mainloop, block: c_int, retval: [*c]c_int) c_int;
extern fn pa_mainloop_run(m: ?*mainloop, retval: [*c]c_int) c_int;
extern fn pa_mainloop_get_api(m: ?*mainloop) [*c]mainloop_api;
extern fn pa_mainloop_quit(m: ?*mainloop, retval: c_int) void;
extern fn pa_mainloop_wakeup(m: ?*mainloop) void;
extern fn pa_mainloop_set_poll_func(m: ?*mainloop, poll_func: poll_func, userdata: ?*anyopaque) void;
extern fn pa_signal_init(api: [*c]mainloop_api) c_int;
extern fn pa_signal_done() void;
extern fn pa_signal_new(sig: c_int, callback: signal_cb_t, userdata: ?*anyopaque) ?*signal_event;
extern fn pa_signal_free(e: ?*signal_event) void;
extern fn pa_signal_set_destroy(e: ?*signal_event, callback: signal_destroy_cb_t) void;
extern fn pa_get_user_name(s: [*c]u8, l: usize) [*c]u8;
extern fn pa_get_host_name(s: [*c]u8, l: usize) [*c]u8;
extern fn pa_get_fqdn(s: [*c]u8, l: usize) [*c]u8;
extern fn pa_get_home_dir(s: [*c]u8, l: usize) [*c]u8;
extern fn pa_get_binary_name(s: [*c]u8, l: usize) [*c]u8;
extern fn pa_path_get_filename(p: [*c]const u8) [*c]u8;
extern fn pa_msleep(t: c_ulong) c_int;
extern fn pa_thread_make_realtime(rtprio: c_int) c_int;
extern fn pa_gettimeofday(tv: [*c]std.c.timeval) [*c]std.c.timeval;
extern fn pa_timeval_diff(a: [*c]const std.c.timeval, b: [*c]const std.c.timeval) usec_t;
extern fn pa_timeval_cmp(a: [*c]const std.c.timeval, b: [*c]const std.c.timeval) c_int;
extern fn pa_timeval_age(tv: [*c]const std.c.timeval) usec_t;
extern fn pa_timeval_add(tv: [*c]std.c.timeval, v: usec_t) [*c]std.c.timeval;
extern fn pa_timeval_sub(tv: [*c]std.c.timeval, v: usec_t) [*c]std.c.timeval;
extern fn pa_timeval_store(tv: [*c]std.c.timeval, v: usec_t) [*c]std.c.timeval;
extern fn pa_timeval_load(tv: [*c]const std.c.timeval) usec_t;
extern fn pa_rtclock_now() usec_t;
