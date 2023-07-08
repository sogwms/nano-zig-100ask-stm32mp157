const std = @import("std");

const UART4_TDR: *u32 = @ptrFromInt(0x40010028);

const GPIO_DR: *u32 = @ptrFromInt(0x50002014);
const GPIO_MODE: *u32 = @ptrFromInt(0x50002000);

fn led_init() void {
    GPIO_MODE.* = 0xf7dfffff;
}

fn led_toggle() void {
    GPIO_DR.* = ~(GPIO_DR.*);
}

fn delay(t: u32) void {
    var i: u32 = 0;

    while (i < t) {
        i += 1;
    }
}

pub fn main() void {
    led_init();

    UART4_TDR.* = 'A';

    while (true) {
        delay(80000);
        led_toggle();
    }
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
