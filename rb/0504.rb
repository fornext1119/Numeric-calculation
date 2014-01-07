# 自作の指数関数
def myExp(x, n, numerator, denominator, y)
    denominator = denominator * n
    numerator   = numerator   * x
    a           = numerator / denominator;
    # 十分な精度になったら処理を抜ける
    if (a.abs <= 0.00000000001)
        y
    else
        y + myExp(x, n + 1, numerator, denominator, a)
    end
end

(0..20).each do |i|
    x  = (i - 10) / 4.0
    # 標準の指数関数
    d1 = Math.exp(x)
    # 自作の指数関数
    d2 = myExp(x, 1, 1.0, 1.0, 1.0)
    # 標準関数との差異
    printf("%5.2f : %13.10f - %13.10f = %13.10f\n", x, d1, d2, d1 - d2)
end
