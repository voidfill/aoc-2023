const std = @import("std");
const expect = std.testing.expect;

fn one(reader: std.io.Reader) i32 {
    _ = reader;
    return 0;
}

fn two(reader: std.io.Reader) i32 {
    _ = reader;
    return 0;
}

pub fn main() !void {}

test "works for example input" {
    var inputFile = try std.fs.cwd().openFile("../example.txt", .{ .mode = std.fs.File.OpenMode.read_only });
    defer inputFile.close();

    var bufferedReader = std.io.bufferedReader(inputFile.reader());
    var in_stream = bufferedReader.reader();
    var result = one(in_stream);

    expect(result == 8);

    bufferedReader = std.io.bufferedReader(inputFile.reader());
    in_stream = bufferedReader.reader();
    result = two(in_stream);

    expect(result == 2286);
}
