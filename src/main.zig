const std = @import("std");
const zap = @import("zap");
const zmpl = @import("zmpl");
const routesUtils = @import("routesUtils.zig");
const globals = @import("globals.zig");

pub fn main() !void {
    globals.routes = globals.RouteMap.initComptime(routesUtils.routesKV);
    const on_request = try routesUtils.dispatcher();
    var listener = zap.HttpListener.init(.{
        .port = 3000,
        .on_request = on_request,
        .log = true,
        .max_clients = 10000,
    });
    try listener.listen();

    std.debug.print("Listening on 0.0.0.0:3000\n",.{});

    zap.start(.{
        .threads = 2,
        .workers = 1,
    });
}
