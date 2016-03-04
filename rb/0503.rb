# 自作の正接関数
def myTan(x, x2, n, t)
    t = x2 / (n - t)
    n -= 2
    if (n <= 1)
        x / (1 - t)
    else
        myTan(x, x2, n, t)
    end
end

(0..12).each do |i|
    if i * 15 % 180 != 0
        degree = i * 15 - 90
        radian = degree * Math::PI / 180
        x2     = radian * radian
        # 自作の正接関数
        d1     = myTan(radian, x2, 15, 0.0) # 15:必要な精度が得られる十分大きな奇数
        # 標準の正接関数
        d2     = Math.tan(radian)
        # 標準関数との差異
        printf("%3d : %13.10f - %13.10f = %13.10f\n", degree, d1, d2, d1 - d2)
    end
end
