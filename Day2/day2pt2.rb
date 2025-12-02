def is_goof(x)
    n_digits = Math.log10(x).floor + 1
    for ngrp in 2..n_digits
        if n_digits % ngrp == 0
            grpsz = n_digits / ngrp
            target = x % (10 ** grpsz)
            match = true
            for i in 1..(ngrp-1)
                candidate = (x / (10 ** (i*grpsz))) % (10 ** grpsz)
                if candidate != target then
                    match = false
                end
            end
            if match then
                return true
            end
        end
    end
    return false
end

def goofs_in_range(min, max)
    sum = 0
    for x in min..max
        if is_goof(x) then
            sum += x
        end
    end
    return sum
end

input = File.open("input.txt").read
ranges = input.split(",").map {|x| x.strip.split("-").map {|y| Integer(y)}}
puts ranges.map {|a| goofs_in_range(a[0], a[1])}.sum
