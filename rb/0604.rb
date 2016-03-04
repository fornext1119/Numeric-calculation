def f(x)
    4 / (1 + x * x)
end

a = 0
b = 1

t = Array.new(7) { Array.new(7) }

# ‘äŒ`‘¥‚ÅÏ•ª
n = 2
(1..6).each do |i|
    h = (b - a) / n.to_f
    s = 0
    x = a
    (1..(n - 1)).each do |j|
        x += h
        s += f(x)
    end
    # Œ‹‰Ê‚ğ•Û‘¶
    t[i][1] = h * ((f(a) + f(b)) / 2 + s)
    n *= 2
end

# Richardson‚Ì•âŠO–@
n = 4
(2..6).each do |j|
    (j..6).each do |i|
        t[i][j] = t[i][j - 1] + (t[i][j - 1] - t[i - 1][j - 1]) / (n - 1)
        if i == j
            # Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
            printf("%2d : %13.10f, %13.10f\n", j, t[i][j], t[i][j] - Math::PI)
        end
    end
    n *= 4
end
