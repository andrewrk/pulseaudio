const std = @import("std");
const pa = @import("pulseaudio");

pub fn render(sine_phase_ref: *f32, sample_spec: pa.sample_spec, buffer: [*]u8, len: usize) void {
    const sample_len = sample_spec.format.sample_size();
    const frame_len = sample_len * sample_spec.channels;
    var offset: usize = 0;
    while (offset + frame_len <= len) {
        const sample = sampleFromF32(sample_spec.format, nextSample(sine_phase_ref, sample_spec.rate));
        for (0..sample_spec.channels) |_| {
            @memcpy((buffer + offset)[0..sample_len], sample.slice());
            offset += sample_len;
        }
    }
}

fn nextSample(sine_phase_ref: *f32, sample_rate: u32) f32 {
    const pitch: f32 = 440;
    const volume: f32 = 0.3;

    const phase_increment: f32 = 2.0 * std.math.pi * pitch / @as(f32, @floatFromInt(sample_rate));
    const sample = volume * @sin(sine_phase_ref.*);
    sine_phase_ref.* += phase_increment;
    if (sine_phase_ref.* >= 2.0 * std.math.pi) {
        sine_phase_ref.* -= 2.0 * std.math.pi;
    }
    return sample;
}

fn sampleFromF32(format: pa.sample_format_t, value: f32) std.BoundedArray(u8, 4) {
    var result: std.BoundedArray(u8, 4) = undefined;
    return switch (format) {
        .S16LE => {
            result.len = 2;
            const scaled = @as(f32, @floatFromInt(std.math.maxInt(i16))) * value;
            const sample = @as(i16, @intFromFloat(@round(scaled)));
            std.mem.writeInt(i16, result.buffer[0..2], sample, .little);
            return result;
        },
        .S16BE => {
            result.len = 2;
            const scaled = @as(f32, @floatFromInt(std.math.maxInt(i16))) * value;
            const sample = @as(i16, @intFromFloat(@round(scaled)));
            std.mem.writeInt(i16, result.buffer[0..2], sample, .big);
            return result;
        },
        .FLOAT32LE => {
            result.len = 4;
            std.mem.writeInt(u32, result.buffer[0..4], @bitCast(value), .little);
            return result;
        },
        .FLOAT32BE => {
            result.len = 4;
            std.mem.writeInt(u32, result.buffer[0..4], @bitCast(value), .big);
            return result;
        },
        .S32LE => {
            result.len = 4;
            const scaled = @as(f64, @floatFromInt(std.math.maxInt(i32))) * @as(f64, value);
            const sample = @as(i32, @intFromFloat(@round(scaled)));
            std.mem.writeInt(i32, result.buffer[0..4], sample, .little);
            return result;
        },
        .S32BE => {
            result.len = 4;
            const scaled = @as(f64, @floatFromInt(std.math.maxInt(i32))) * @as(f64, value);
            const sample = @as(i32, @intFromFloat(@round(scaled)));
            std.mem.writeInt(i32, result.buffer[0..4], sample, .big);
            return result;
        },
        .U8, .S24LE, .S24BE, .S24_32LE, .S24_32BE, .ALAW, .ULAW => @panic(
            "unsupported sample format",
        ),
        .MAX, .INVALID => unreachable,
    };
}
