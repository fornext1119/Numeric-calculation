// 自作の余弦関数
def myCos(x:Double, n:Int, nega:Boolean, numerator:Double, denominator:Double, y:Double):Double = {
    val m     = 2 * n
    val denom = denominator * m * (m - 1)
    val num   = numerator   * x * x
    val a     = num / denom
    // 十分な精度になったら処理を抜ける
    if (a <= 0.00000000001) 
        y
    else
        y + myCos(x, n + 1, !nega, num, denom, if (nega) a else -a)
}
(0 to 24).
    map(_ * 15).
    filter(n => (n % 30 == 0) || (n % 45 == 0)).
    foreach { degree =>
        val radian = Math.toRadians(degree)
        // 自作の余弦関数
        val d1 = myCos(radian, 1, false, 1.0, 1.0, 1.0)
        // 標準の余弦関数
        val d2 = Math.cos(radian)
        // 標準関数との差異
        System.out.println("%3d : %13.10f - %13.10f = %13.10f".format(degree, d1, d2, d1 - d2));
    }
