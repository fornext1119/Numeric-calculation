def f(x)
    4 / (1 + x * x)
end

a = 0
b = 1

# ���_���Őϕ�
n = 2
(1..10).each do |j|
    h = (b - a) / n.to_f
    s = 0
    x = a + (h / 2)
    (1..n).each do |i|
        s += f(x)
        x += h
    end
    s *= h
    n *= 2

    # ���ʂ� �� �Ɣ�r
    printf("%2d : %13.10f, %13.10f\n", j, s, s - Math::PI)
end
