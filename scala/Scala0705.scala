object Scala0705 {
    // データ点の数 - 1
    val N = 6 

    def main(args: Array[String]) {
        // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
        val x = (0 to N).map(_ * 1.5 - 4.5)
        val y = x.map(f)

		// ３項方程式の係数の表を作る
		val a = Array.ofDim[Double](N)
		val b = Array.ofDim[Double](N)
		val c = Array.ofDim[Double](N)
		val d = Array.ofDim[Double](N)
		for (i <- 1 to N - 1) {
	        a(i) =         x(i)   - x(i-1) 
	        b(i) = 2.0 *  (x(i+1) - x(i-1)) 
	        c(i) =         x(i+1) - x(i) 
	        d(i) = 6.0 * ((y(i+1) - y(i)) / (x(i+1) - x(i)) - (y(i) - y(i-1)) / (x(i) - x(i-1)))
	    }
		// ３項方程式を解く (ト－マス法)
		val g = Array.ofDim[Double](N)
		val s = Array.ofDim[Double](N)
	    g(1) = b(1)
	    s(1) = d(1)
		for (i <- 2 to N - 1) {
	        g(i) = b(i) - a(i) * c(i-1) / g(i-1)
	        s(i) = d(i) - a(i) * s(i-1) / g(i-1)
	    }
        val z = Array.ofDim[Double](N + 1)
	    z(0)   = 0
	    z(N)   = 0
	    z(N-1) = s(N-1) / g(N-1)
	    for (i <- N - 2 to 1 by -1)
	        z(i) = (s(i) - c(i) * z(i+1)) / g(i)

        // 0.5刻みで 与えられていない値を補間
        val d1 = (0 to 18).map(_ * 0.5 - 4.5)
        val d2 = d1.map(f)
        val d3 = d1.map(spline(_, x, y, z))

        (d1 zip d2 zip d3).foreach { 
            case ((d1, d2), d3) => 
                println("%5.2f\t%8.5f\t%8.5f\t%8.5f".format(d1, d2, d3, d2 - d3))
        }
    }

    // 元の関数
    def f(x:Double) = {
        x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2)
    }

	// Spline (スプライン) 補間
    def spline(d:Double, x:IndexedSeq[Double], y:IndexedSeq[Double], z:IndexedSeq[Double]) = {
	    // 補間関数値がどの区間にあるか
	    var k = -1
	    for (i <- N to 1 by -1) {
	        if (d <= x(i)) k = i - 1
	    }
        if (k < 0) k = N

	    val d1 = x(k+1) - d
	    val d2 = d      - x(k)
	    val d3 = x(k+1) - x(k)
	    (z(k) * Math.pow(d1,3) + z(k+1) * Math.pow(d2,3)) / (6.0 * d3) +
	    (y(k)   / d3 - z(k)   * d3 / 6.0) * d1 +
	    (y(k+1) / d3 - z(k+1) * d3 / 6.0) * d2
    }
}
