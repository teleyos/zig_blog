const zap = @import("zap");
const std = @import("std");
const zmpl = @import("zmpl");
const globals = @import("globals.zig");

pub fn indexHandler(r: zap.Request, allocator: std.mem.Allocator) !void {
    var data = zmpl.Data.init(allocator);
    defer data.deinit();

    if(zmpl.find("index")) |template| {
        const output = try template.render(
            &data,
            globals.zmplContext,
            .{},
            .{}
        );
        try r.sendBody(output);
    }
}

pub fn testHandler(r: zap.Request, allocator: std.mem.Allocator) !void {
    var data = zmpl.Data.init(allocator);
    defer data.deinit();

    if(zmpl.find("test")) |template| {
        const output = try template.render(
            &data,
            globals.zmplContext,
            .{},
            .{}
        );
        try r.sendBody(output);
    }
}

pub fn unknownHandler(r: zap.Request, allocator: std.mem.Allocator) !void {
    var data = zmpl.Data.init(allocator);
    defer data.deinit();

    if(zmpl.find("error404")) |template| {
        const output = try template.render(
            &data,
            globals.zmplContext,
            .{},
            .{}
        );
        try r.sendBody(output);
    }
}
