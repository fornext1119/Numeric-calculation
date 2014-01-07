// 自作の正弦関数
def mySin(x:Double, n:Int, nega:Boolean, numerator:Double, denominator:Double, y:Double):Double = {
    val m     = 2 * n
    val denom = denominator * (m + 1) * m
    val num   = numerator   * x * x
    val a     = num / denom
    // 十分な精度になったら処理を抜ける
    if (a <= 0.00000000001) 
        y
    else
        y + mySin(x, n + 1, !nega, num, denom, if (nega) a else -a)
}
(0 to 24).
    map(_ * 15).
    // 0° ～ 360° のうち 30°, 45° の倍数
    filter(n => (n % 30 == 0) || (n % 45 == 0)).
    // ラジアン
    map(degree => (degree, Math.toRadians(degree))).
    // 標準の正弦関数 と 自作の正弦関数
    map(t => (t._1, Math.sin(t._2), mySin(t._2, 1, false, t._2, 1.0, t._2))).
    // 標準関数との差異
    foreach {t => t 
        match {
            case (degree, d1, d2) => println("%3d : %13.10f - %13.10f = %13.10f".format(degree, d1, d2, d1 - d2))
        }
    }
(0 to 24).
    map(_ * 15).
    filter(n => (n % 30 == 0) || (n % 45 == 0)).
    foreach { degree =>
        val radian = Math.toRadians(degree)
        // 自作の正弦関数
        val d1 = mySin(radian, 1, false, radian, 1.0, radian)
        // 標準の正弦関数
        val d2 = Math.sin(radian)
        // 標準関数との差異
        println("%3d : %13.10f - %13.10f = %13.10f".format(degree, d1, d2, d1 - d2));
    }
