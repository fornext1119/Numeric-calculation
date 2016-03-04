// 自作の正接関数
def myTan(x:Double, x2:Double, n:Int, t:Double):Double = {
    val denom = x2 / (n - t)
    val num   = n - 2
    if (num <= 1) 
        x / (1 - denom)
    else
        myTan(x, x2, num, denom)
}
(0 to 12).
    map(_ * 15).
    filter(n => n % 180 != 0).
    map(_ - 90).
    foreach { degree =>
        val radian = Math.toRadians(degree)
        val x2     = radian * radian
        // 自作の正接関数
        val d1 = myTan(radian, x2, 15, 0.0) // 15:必要な精度が得られる十分大きな奇数
        // 標準の正接関数
        val d2 = Math.tan(radian)
        // 標準関数との差異
        System.out.println("%3d : %13.10f - %13.10f = %13.10f".format(degree, d1, d2, d1 - d2));
    }
