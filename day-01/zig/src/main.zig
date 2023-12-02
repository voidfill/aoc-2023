const std = @import("std");

fn one(input: *u8) i32 {
    const split = std.mem.split(u8, input, "\n");
    while (split.next()) |line| {
        const subSplit = std.mem.split(u8, line, "");
        while (subSplit.next()) |character| {
            _ = character;
        }
    }
}

fn two(input: *c_char) i32 {
    _ = input;
}

pub fn main() !void {
    const data = @embedFile("./input.txt");
    _ = data;
}

test "simple test" {
    const data = @embedFile("./example.txt");
    std.testing.expectEqual(142, one(@as(*[]u8, data)));
}
