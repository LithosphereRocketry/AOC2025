BEGIN {
    pos = 50
    score = 0
}
match($0, /^L([0-9]*)/, m) {
    pos = (pos + 100 - m[1]) % 100
    if (pos == 0) score++
}
match($0, /^R([0-9]*)/, m) {
    pos = (pos + m[1]) % 100
    if (pos == 0) score++
}
END {
    print score
}