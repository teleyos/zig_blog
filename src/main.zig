const std = @import("std");
const zap = @import("zap");
const zmpl = @import("zmpl");

const allocator = std.heap.page_allocator;
const Context = struct { foo: []const u8 = "default"};

fn on_request(r: zap.Request) !void {
    var data = zmpl.Data.init(allocator);
    defer data.deinit();

    var body = try data.object();

    if (r.getParamSlice("name")) |name| {
        try body.put("name", data.string(name));
    }else{
        r.sendError(error.NoNameQuery, null, 500);
    }

    if(zmpl.find("test")) |template| {
        const output = try template.render(
            &data,
            Context,
            .{},
            .{}
        );
        try r.sendBody(output);
    }
}

pub fn main() !void {
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

