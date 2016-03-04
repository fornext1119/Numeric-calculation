object Scala0803 {

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

	    // 中点法
		midpoint(1, vx, vy, x, y)
	}

	def midpoint(i:Int, vx:Double, vy:Double, x:Double, y:Double):Unit = {
	    // 経過秒数
	    val t = i * h

        // 位置・速度
        val wvx1 = h * fx(vx, vy)
        val wvy1 = h * fy(vx, vy)
        val wvx2 = vx + wvx1 / 2
        val wvy2 = vy + wvy1 / 2

        val wvx = vx + h * fx(wvx2, wvy2)
        val wvy = vy + h * fy(wvx2, wvy2)
        val wx  = x  + h *    wvx2
        val wy  = y  + h *    wvy2

        println("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f".format(t, wvx, wvy, wx, wy))

		if (wy >= 0.0)
			midpoint(i+1, wvx, wvy, wx, wy)
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
