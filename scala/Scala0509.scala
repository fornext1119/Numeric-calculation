// 自作の双曲線余弦関数
def myCosh(x:Double, n:Int, numerator:Double, denominator:Double, y:Double):Double = {
    val m     = 2 * n
    val denom = denominator * m * (m - 1)
    val num   = numerator   * x * x
    val a     = num / denom
    // 十分な精度になったら処理を抜ける
    if (Math.abs(a) <= 0.00000000001) 
        y
    else
        y + myCosh(x, n + 1, num, denom, a)
}
(0 to 20).
    map(_ - 10).
    foreach { x =>
        // 自作の双曲線余弦関数
        val d1 = myCosh(x, 1, 1.0, 1.0, 1.0)
        // 標準の双曲線余弦関数
        val d2 = Math.cosh(x)
        // 標準関数との差異
        System.out.println("%3d : %17.10f - %17.10f = %13.10f".format(x, d1, d2, d1 - d2));
    }
