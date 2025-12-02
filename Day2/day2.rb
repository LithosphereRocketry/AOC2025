def tri(x)
    return x*(x-1)/2
end

def sum_goofs_with_halfdigits(x)
    return (tri(10**x) - tri(10**(x-1))) * (1 + 10**x)
end

def sum_goofs_less_than(x)
    n_digits = Math.log10(x).floor + 1
    # goofs inherent to the shorter number of digits
    # this is the same thing as saying "how many (n-1)/2 digit numbers are there
    # not counting zero"
    sum = 0
    for hd in 1..(n_digits-1)/2
        sum += sum_goofs_with_halfdigits(hd)
    end
    if n_digits % 2 == 0 then
        hd = n_digits/2
        upperhalf = x / 10**hd
        lowerhalf = x % 10**hd
        sum += (tri(upperhalf+1) - tri(10**(hd-1))) * (1 + 10**hd)
        if upperhalf >= lowerhalf then
            sum -= upperhalf * (1 + 10**hd)
        end
    end
    return sum
end

def goofs_in_range(x, y)
    return sum_goofs_less_than(y+1) - sum_goofs_less_than(x)
end

# puts sum_goofs_less_than(998)
# puts sum_goofs_less_than(1012)
# puts goofs_in_range(998, 1012)

input = File.open("input.txt").read
ranges = input.split(",").map {|x| x.strip.split("-").map {|y| Integer(y)}}
puts ranges.map {|a| goofs_in_range(a[0], a[1])}.sum
