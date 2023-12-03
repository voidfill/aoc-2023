const std = @import("std");
const expect = std.testing.expect;

fn one(reader: anytype) !?i32 {
    var acc: i32 = 0;
    var buf: [1024]u8 = undefined;
    var ln: i32 = 0;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var it = std.mem.split(u8, line, &[_]u8{ ':', ' ' });
        var isFirst = true;

        while (it.next()) |ch| {
            if (isFirst) {
                isFirst = false;
                continue;
            }
            var invalid = false;

            ln = ln + 1;
            var it2 = std.mem.split(u8, ch, &[_]u8{ ';', ' ' });
            while (it2.next()) |draws| {
                var it3 = std.mem.split(u8, draws, &[_]u8{ ',', ' ' });
                while (it3.next()) |draw| {
                    var it4 = std.mem.split(u8, draw, &[_]u8{' '});
                    var n = it4.next();
                    if (n) |num| {
                        var numParsed = try std.fmt.parseInt(i32, num, 10);
                        var c = it4.next();

                        if (c) |cc| {
                            if (std.mem.eql(u8, cc, "red") and numParsed > 12) {
                                invalid = true;
                            }
                            if (std.mem.eql(u8, cc, "green") and numParsed > 13) {
                                invalid = true;
                            }
                            if (std.mem.eql(u8, cc, "blue") and numParsed > 14) {
                                invalid = true;
                            }
                        }
                    }
                }
            }

            if (!invalid) {
                acc += ln;
            }
        }
    }

    return acc;
}

fn two(reader: anytype) !?i32 {
    var acc: i32 = 0;
    var buf: [1024]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var it = std.mem.split(u8, line, &[_]u8{ ':', ' ' });
        var isFirst = true;

        var red: i32 = 0;
        var green: i32 = 0;
        var blue: i32 = 0;

        while (it.next()) |ch| {
            if (isFirst) {
                isFirst = false;
                continue;
            }

            var it2 = std.mem.split(u8, ch, &[_]u8{ ';', ' ' });
            while (it2.next()) |draws| {
                var it3 = std.mem.split(u8, draws, &[_]u8{ ',', ' ' });
                while (it3.next()) |draw| {
                    var it4 = std.mem.split(u8, draw, &[_]u8{' '});
                    var n = it4.next();
                    if (n) |num| {
                        var numParsed = try std.fmt.parseInt(i32, num, 10);
                        var c = it4.next();

                        if (c) |cc| {
                            if (std.mem.eql(u8, cc, "red") and numParsed > red) {
                                red = numParsed;
                            }
                            if (std.mem.eql(u8, cc, "green") and numParsed > green) {
                                green = numParsed;
                            }
                            if (std.mem.eql(u8, cc, "blue") and numParsed > blue) {
                                blue = numParsed;
                            }
                        }
                    }
                }
            }
        }
        acc += red * green * blue;
    }

    return acc;
}

pub fn main() !void {
    var inputFile = try std.fs.cwd().openFile("../input.txt", .{ .mode = std.fs.File.OpenMode.read_only });

    var bufferedReader = std.io.bufferedReader(inputFile.reader());
    var in_stream = bufferedReader.reader();
    var result = try one(in_stream);
    inputFile.close();

    std.debug.print("one: {any}\n", .{result});

    inputFile = try std.fs.cwd().openFile("../input.txt", .{ .mode = std.fs.File.OpenMode.read_only });
    bufferedReader = std.io.bufferedReader(inputFile.reader());
    in_stream = bufferedReader.reader();
    result = try two(in_stream);
    inputFile = try std.fs.cwd().openFile("../input.txt", .{ .mode = std.fs.File.OpenMode.read_only });
    inputFile.close();

    std.debug.print("two: {any}\n", .{result});
}

test "works for example input" {
    var inputFile = try std.fs.cwd().openFile("../example.txt", .{ .mode = std.fs.File.OpenMode.read_only });

    var bufferedReader = std.io.bufferedReader(inputFile.reader());
    var in_stream = bufferedReader.reader();
    var result = try one(in_stream);

    inputFile.close();

    std.debug.print("output one: {any}\n", .{result});

    try expect(result == 8);

    inputFile = try std.fs.cwd().openFile("../example.txt", .{ .mode = std.fs.File.OpenMode.read_only });
    bufferedReader = std.io.bufferedReader(inputFile.reader());
    in_stream = bufferedReader.reader();
    result = try two(in_stream);
    inputFile.close();

    std.debug.print("output two: {any}\n", .{result});
    try expect(result == 2286);
}
