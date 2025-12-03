open 1,"input.txt"
total=0
dim digits(12)
while !eof(1)
    input #1 line$
    for i=1 to 12 step 1
        digits(i)=-1
    next i
    for i=1 to len(line$) step 1
        num=asc(mid$(line$,i,1))-asc("0")
        for j=12 to 1 step -1
            if num>digits(j) and i+j-2<len(line$) then
                digits(j)=num
                for k=j-1 to 1 step -1
                    digits(k)=-1
                next k
                break
            fi
        next j
    next i
    linetot=0
    for i=12 to 1 step -1
        linetot=linetot*10+digits(i)
    next i
    total=total+linetot
wend
print total using "####################"
