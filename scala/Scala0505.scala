// 自作の指数関数
def myExp(x:Double, x2:Double, n:Int, t:Double):Double = {
    val denom = x2 / (n + t)
    val num   = n - 4  

    if (num < 6)
        1 + ((2 * x) / (2 - x + denom))
    else
        myExp(x, x2, num, denom)
}
(0 to 20).
    map(n => (n - 10) / 4.0).
    foreach { x =>
        // 標準の指数関数
        val d1 = Math.exp(x)
        // 自作の指数関数
        val x2 = x * x
        val d2 = myExp(x, x2, 30, 0.0) // 30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
        // 標準関数との差異
        System.out.println("%5.2f : %13.10f - %13.10f = %13.10f".format(x, d1, d2, d1 - d2))
    }
