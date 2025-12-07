import std::core;
import std::io;
import std::collections;

fn void main() {
    File f = std::io::file::open("input.txt", "r")!!;
    std::core::dstring::DString fdata;
    (void) fdata.read_from_stream(&f);
    String[] lines = fdata.str_view().tsplit("\n");
    std::collections::list::List{long} hits;
    foreach(i, v : lines[0]) {
        hits.push(v == 'S' ? 1 : 0);
    }
    
    long score = 0;
    foreach(i, line : lines[1 .. ]) {
        std::collections::list::List{long} new_hits;

        foreach(j, v : hits) {
            long new_hit = 0;
            if(j-1 >= 0 && hits[j-1] && line[j-1] == '^') {
                new_hit += hits[j-1];
            }
            if(j+1 < line.len && hits[j+1] && line[j+1] == '^') {
                new_hit += hits[j+1];
            }
            if(line[j] != '^') {
                new_hit += hits[j];
            }
            new_hits.push(new_hit);
        }
        hits = new_hits;
    }
    foreach(k, h : hits) score += h;
    std::io::printn(score);
}