const std = @import("std");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
var alloc = gpa.allocator();

const pt_t = struct { x: i64, y: i64, z: i64 };

const n_links = 1000;
const n_top = 3;

fn compareLen(context: []i64, a: usize, b: usize) bool {
    return context[a] < context[b];
}

pub fn main() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    const file_stat = try file.stat();

    const input = try file.readToEndAlloc(alloc, file_stat.size);
    const len = std.mem.count(u8, input, "\n") + 1;
    defer alloc.free(input);

    var lines = std.mem.splitScalar(u8, input, '\n');

    const ptbuf = try alloc.alloc(pt_t, len);
    for (ptbuf) |*newpt| {
        const ptstr = lines.next().?;
        var pts = std.mem.splitScalar(u8, ptstr, ',');
        newpt.* = pt_t{
            .x = try std.fmt.parseInt(i64, pts.next().?, 10),
            .y = try std.fmt.parseInt(i64, pts.next().?, 10),
            .z = try std.fmt.parseInt(i64, pts.next().?, 10)
        };
    }

    const lensqbuf = try alloc.alloc(i64, len*len);
    for (lensqbuf) |*l| { l.* = std.math.maxInt(i64); }
    for (ptbuf, 0..) |pt1, i_1| {
        for(ptbuf[i_1+1..], i_1+1..) |pt2, i_2| {
            lensqbuf[i_1*len + i_2] = (
                (pt2.x - pt1.x)*(pt2.x - pt1.x)
              + (pt2.y - pt1.y)*(pt2.y - pt1.y)
              + (pt2.z - pt1.z)*(pt2.z - pt1.z)
            );
        }
    }
    
    const sorted = try alloc.alloc(usize, len*len);
    for(sorted, 0..) |*s, i| { s.* = i; }
    std.mem.sort(usize, sorted, lensqbuf, compareLen);

    const colors = try alloc.alloc(u64, len);
    for(colors) |*c| { c.* = 0; }
    var nextcolor: u64 = 1;

    for(sorted[0..n_links]) |link| {
        const first = link / len;
        const second = link % len;

        var activecolor = nextcolor;
        if(colors[first] > 0) {
            activecolor = colors[first];
        } else {
            colors[first] = activecolor;
            nextcolor += 1;
        }

        if(colors[second] == colors[first]) continue;

        if(colors[second] > 0) {
            const repaint = colors[second];
            for(colors) |*c| {
                if(c.* == repaint) { c.* = activecolor; }
            }
        } else {
            colors[second] = activecolor;
        }
    }

    var ccounts = try alloc.alloc(usize, nextcolor);
    for(ccounts) |*c| { c.* = 0; }
    for(colors) |c| {
        ccounts[c] += 1;
    }

    const topcolors = try alloc.alloc(usize, n_top);
    for(topcolors) |*t| { t.* = 0; }
    for(ccounts[1..]) |c| {
        var currentc = c;
        for(topcolors) |*t| {
            if(currentc > t.*) {
                const tmp = t.*;
                t.* = currentc;
                currentc = tmp;
            }
        }
    }

    var score: usize = 1;
    for(topcolors) |c| { score *= c; }
    std.debug.print("part 1 {d}\n", .{score});

    // PART 2
    for(colors) |*c| { c.* = 0; }
    nextcolor = 1;
    var unpainted = len;
    var assimilated: usize = 0;

    for(sorted) |link| {
        const first = link / len;
        const second = link % len;

        var activecolor = nextcolor;
        if(colors[first] > 0) {
            activecolor = colors[first];
        } else {
            colors[first] = activecolor;
            nextcolor += 1;
            unpainted -= 1;
        }

        if(colors[second] == colors[first]) continue;

        if(colors[second] > 0) {
            const repaint = colors[second];
            for(colors) |*c| {
                if(c.* == repaint) { c.* = activecolor; }
            }
            assimilated += 1;
        } else {
            colors[second] = activecolor;
            unpainted -= 1;
        }

        if(unpainted == 0 and nextcolor - assimilated == 2) {
            std.debug.print("part 2 {d}\n", .{ptbuf[first].x * ptbuf[second].x});
            break;    
        }
    }
}
