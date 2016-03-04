object Scala0804 {

    // 重力加速度
	val g = -9.8
	// 空気抵抗係数
	val k = -0.01
	// 時間間隔(秒)
	val h = 0.01

    def main(args: Array[String]) {
	    // 角度
	    val degree = 45
	    val radian = degree * Math.PI / 180.0
	    // 初速 250 km/h -> 秒速に変換
	    val v = 250 * 1000 / 3600
	    // 水平方向の速度
		val vx = v * Math.cos(radian)
	    // 鉛直方向の速度
		val vy = v * Math.sin(radian)
	    // 位置
	    val x = 0.0
	    val y = 0.0

	    // Runge-Kutta法
		rungekutta(1, vx, vy, x, y)
	}

	def rungekutta(i:Int, vx:Double, vy:Double, x:Double, y:Double):Unit = {
	    // 経過秒数
	    val t = i * h

        // 位置・速度
        val wx1  = h *    vx
        val wy1  = h *    vy
        val wvx1 = h * fx(vx, vy)
        val wvy1 = h * fy(vx, vy)

        val wvx5 = vx + wvx1 / 2
        val wvy5 = vy + wvy1 / 2
        val wx2  = h *    wvx5
        val wy2  = h *    wvy5
        val wvx2 = h * fx(wvx5, wvy5)
        val wvy2 = h * fy(wvx5, wvy5)

        val wvx6 = vx + wvx2 / 2
        val wvy6 = vy + wvy2 / 2
        val wx3  = h *    wvx6
        val wy3  = h *    wvy6
        val wvx3 = h * fx(wvx6, wvy6)
        val wvy3 = h * fy(wvx6, wvy6)

        val wvx7 = vx + wvx3
        val wvy7 = vy + wvy3
        val wx4  = h *    wvx7
        val wy4  = h *    wvy7
        val wvx4 = h * fx(wvx7, wvy7)
        val wvy4 = h * fy(wvx7, wvy7)

        val wx  = x  + ( wx1 +  wx2 * 2 +  wx3 * 2 +  wx4) / 6
        val wy  = y  + ( wy1 +  wy2 * 2 +  wy3 * 2 +  wy4) / 6
        val wvx = vx + (wvx1 + wvx2 * 2 + wvx3 * 2 + wvx4) / 6
        val wvy = vy + (wvy1 + wvy2 * 2 + wvy3 * 2 + wvy4) / 6

        println("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f".format(t, wvx, wvy, wx, wy))

		if (wy >= 0.0)
			rungekutta(i+1, wvx, wvy, wx, wy)
		else
			()
	}

	// 空気抵抗による水平方向の減速分
	def fx(vx:Double, vy:Double) = {
	    k * Math.sqrt(vx * vx + vy * vy) * vx
	}
	// 重力と空気抵抗による鉛直方向の減速分
	def fy(vx:Double, vy:Double) = {
	    g + (k * Math.sqrt(vx * vx + vy * vy) * vy)
	}
}
