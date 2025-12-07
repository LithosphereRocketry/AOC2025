import std::core;
import std::io;
import std::collections;

fn void main() {
    File f = std::io::file::open("input.txt", "r")!!;
    std::core::dstring::DString fdata;
    (void) fdata.read_from_stream(&f);
    String[] lines = fdata.str_view().tsplit("\n");
    std::collections::list::List{bool} hits;
    foreach(i, v : lines[0]) {
        hits.push(v == 'S');
    }
    
    long score = 0;
    foreach(i, line : lines[1 .. ]) {
        std::collections::list::List{bool} new_hits;
        std::collections::list::List{bool} new_splits;
        foreach(j, v : lines[0]) {
            new_splits.push(false);
        }

        foreach(j, v : hits) {
            bool new_hit = false;
            if(j-1 >= 0 && hits[j-1] && line[j-1] == '^') {
                new_hit = true;
                new_splits[j-1] = true;
            }
            if(j+1 < line.len && hits[j+1] && line[j+1] == '^') {
                new_hit = true;
                new_splits[j+1] = true;
            }
            bool old_hit = hits[j] && line[j] != '^';
            new_hits.push(new_hit || old_hit);
        }
        hits = new_hits;
        foreach(k, h : new_splits) if(h) score++;
    }
    std::io::printn(score);
}