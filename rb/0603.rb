def f(x)
    4 / (1 + x * x)
end

a = 0
b = 1

# Simpson‘¥‚ÅÏ•ª
n = 2
(1..5).each do |j|
    h  = (b - a) / n.to_f
    s2 = 0
    s4 = 0
    x  = a + h
    (1..(n / 2)).each do |i|
        s4 += f(x)
        x  += h
        s2 += f(x)
        x  += h
    end
    s2 = (s2 - f(b)) * 2 + f(a) + f(b)
    s4 *= 4
    s  = (s2 + s4) * h / 3
    n  *= 2

    # Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    printf("%2d : %13.10f, %13.10f\n", j, s, s - Math::PI)
end
