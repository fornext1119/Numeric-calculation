// 自作の対数関数
def myLog(x:Double, n:Int, t:Double):Double = {
    var n2 = n
    var x2 = x
    if (n > 3) {
        if (n % 2 == 0)
            n2 = 2
        x2 = x * (n / 2)
    }
    val t2 = x2 / (n2 + t)

    if (n <= 2)
        x / (1 + t2)
    else
        myLog(x, n - 1, t2)
}
(1 to 20).
    map(_ / 5.0).
    foreach { x =>
        // 標準の対数関数
        val d1 = Math.log(x)
        // 自作の対数関数
        val d2 = myLog(x - 1, 27, 0.0) // 27:必要な精度が得られる十分大きな奇数
        // 標準関数との差異
        System.out.println("%5.2f : %13.10f - %13.10f = %13.10f".format(x, d1, d2, d1 - d2))
    }
