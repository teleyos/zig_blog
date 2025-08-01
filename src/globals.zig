const std = @import("std");
const zap = @import("zap");

pub const allocator = std.heap.page_allocator;
pub const zmplContext = struct { foo: []const u8 = "default"};

pub const HttpRequestFnAlloc = *const fn (zap.Request, std.mem.Allocator) anyerror!void;
pub const RouteMap = std.StaticStringMap(HttpRequestFnAlloc);
pub const RouteKV = struct {[]const u8, HttpRequestFnAlloc};
pub var routes : RouteMap = undefined;
