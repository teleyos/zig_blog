const std = @import("std");
const zap = @import("zap");
const handlers = @import("handlers.zig");
const globals = @import("globals.zig");

pub fn dispatcher() !zap.HttpRequestFn {
    return struct {
        fn call(r: zap.Request) anyerror!void {
            if(r.path) |path| {
                if (globals.routes.get(path)) |foo| {
                    try foo(r,globals.allocator);
                    return;
                }else{
                    try handlers.unknownHandler(r, globals.allocator);
                    return;
                }
            }
        }
    }.call;
}

pub const routesKV: []const globals.RouteKV = &.{
    .{"/404", handlers.unknownHandler},
    .{"/", handlers.indexHandler},
    .{"/home", handlers.indexHandler},
    .{"/index", handlers.indexHandler},
    .{"/test", handlers.testHandler},
};

