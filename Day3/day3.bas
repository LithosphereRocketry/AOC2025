open 1,"input.txt"
total=0
while !eof(1)
    input #1 line$
    tens=-1
    ones=-1
    for i=1 to len(line$) step 1
        num=asc(mid$(line$,i,1))-asc("0")
        if (num>ones) ones=num
        if (num>tens and i<len(line$)) then
            tens=num
            ones=-1
        fi
    next i
    total=total+10*tens+ones
wend
print total
