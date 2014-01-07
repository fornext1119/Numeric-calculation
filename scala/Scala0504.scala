// 自作の指数関数
def myExp(x:Double, n:Int, numerator:Double, denominator:Double, y:Double):Double = {
    val denom = denominator * n
    val num   = numerator   * x
    val a     = num / denom
    // 十分な精度になったら処理を抜ける
    if (Math.abs(a) <= 0.00000000001)
        y
    else
        y + myExp(x, n + 1, num, denom, a)
}
(0 to 20).
    map(n => (n - 10) / 4.0).
    foreach { x =>
        // 標準の指数関数
        val d1 = Math.exp(x)
        // 自作の指数関数
        val d2 = myExp(x, 1, 1.0, 1.0, 1.0)
        // 標準関数との差異
        System.out.println("%5.2f : %13.10f - %13.10f = %13.10f".format(x, d1, d2, d1 - d2));
    }
