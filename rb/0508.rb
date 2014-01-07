# 自作の双曲線正弦関数
def mySinh(x, n, numerator, denominator, y)
    m           = 2 * n
    denominator = denominator * (m + 1) * m
    numerator   = numerator * x * x
    a           = numerator / denominator
    # 十分な精度になったら処理を抜ける
    if (a.abs <= 0.00000000001)
        y
    else
        y + mySinh(x, n + 1, numerator, denominator, a)
    end
end

(0..20).each do |i|
    x = i - 10
    # 自作の双曲線正弦関数
    d1     = mySinh(x, 1, x, 1.0, x)
    # 標準の双曲線正弦関数
    d2     = Math.sinh(x)
    # 標準関数との差異
    printf("%3d : %17.10f - %17.10f = %13.10f\n", x, d1, d2, d1 - d2)
end
