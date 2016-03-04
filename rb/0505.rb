# 自作の指数関数
def myExp(x, x2, n, t)
    t = x2 / (n + t)
    n -= 4
    if (n < 6)
        1 + ((2 * x) / (2 - x + t))
    else
        myExp(x, x2, n, t)
    end
end

(0..20).each do |i|
    x  = (i - 10) / 4.0
    # 標準の指数関数
    d1 = Math.exp(x)
    # 自作の指数関数
    x2 = x * x
    d2 = myExp(x, x2, 30, 0.0) # 30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
    # 標準関数との差異
    printf("%5.2f : %13.10f - %13.10f = %13.10f\n", x, d1, d2, d1 - d2)
end
