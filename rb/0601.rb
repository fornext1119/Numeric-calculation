def f(x)
    4 / (1 + x * x)
end

a = 0
b = 1

# ��`���Őϕ�
n = 2
(1..10).each do |j|
    h = (b - a) / n.to_f
    s = 0
    x = a
    (1..(n - 1)).each do |i|
        x += h
        s += f(x)
    end
    s = h * ((f(a) + f(b)) / 2 + s)
    n *= 2

    # ���ʂ� �� �Ɣ�r
    printf("%2d : %13.10f, %13.10f\n", j, s, s - Math::PI)
end
