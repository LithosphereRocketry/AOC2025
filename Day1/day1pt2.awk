BEGIN {
    pos = 50
    score = 0
}
match($0, /^L([0-9]*)/, m) {
    print m[0]
    if (pos == 0) pos += 100
    pos -= m[1]
    while (pos < 0) {
        print "tick"
        score ++ 
        pos += 100
    }
    if (pos == 0) score ++
}
match($0, /^R([0-9]*)/, m) {
    print m[0]
    pos += m[1]
    while (pos >= 100) {
        print "tick"
        score ++
        pos -= 100
    }
}
END {
    print pos
    print score
}