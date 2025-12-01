BEGIN {
    pos = 50
    score = 0
}
match($0, /^L([0-9]*)/, m) {
    if (pos == 0) pos += 100
    pos -= m[1]
    while (pos < 0) {
        score ++ 
        pos += 100
    }
    if (pos == 0) score ++
}
match($0, /^R([0-9]*)/, m) {
    pos += m[1]
    while (pos >= 100) {
        score ++
        pos -= 100
    }
}
END {
    print pos
    print score
}