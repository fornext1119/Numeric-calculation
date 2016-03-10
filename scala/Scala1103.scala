object Scala1103 {
    val N = 3

	// LR分解で固有値を求める
    def main(args: Array[String]) {
		var a:Array[Array[Double]] = Array(Array(5.0, 4.0, 1.0, 1.0)
                                          ,Array(4.0, 5.0, 1.0, 1.0)
                                          ,Array(1.0, 1.0, 4.0, 2.0)
                                          ,Array(1.0, 1.0, 2.0, 4.0))

        var e:Double = 0.0
        var k = 1
		do {
		    // LU分解
			var (l, u) = decomp(a)
	        // 行列の積
	        a = multiply(u, l)
	        // 対角要素を表示
            print("%3d\t".format(k))
	        disp_eigenvalue(a)
            k += 1

	        // 収束判定
            e = 0.0
            for (i <- 0 to N)
                for (j <- 0 to (i - 1))
                    e += Math.abs(a(i)(j))

		} while (k <= 200 && e >= 0.00000000001)

        println()
        println("eigenvalue")
        disp_eigenvalue(a)
    }

	// LU分解
    def decomp(a:Array[Array[Double]]): (Array[Array[Double]], Array[Array[Double]]) = {
		var l = Array.ofDim[Double](N + 1, N + 1)
		var u = Array.ofDim[Double](N + 1, N + 1)

	    l(0)(0) = 1.0
        for (j <- 0 to N)
	        u(0)(j) = a(0)(j)

        for (i <- 1 to N) {
	        u(i)(0) = 0.0
	        l(0)(i) = 0.0
	        l(i)(0) = a(i)(0) / u(0)(0)
	    }
        for (i <- 1 to N) {
	        l(i)(i) = 1.0
	        var t:Double = a(i)(i)
	        for (k <- 0 to i)
	            t -= l(i)(k) * u(k)(i)
	        u(i)(i) = t
	        for (j <- i + 1 to N) {
	            u(j)(i) = 0.0
                l(i)(j) = 0.0
	            t       = a(j)(i)
		        for (k <- 0 to i)
	                t -= l(j)(k) * u(k)(i)
	            l(j)(i) = t / u(i)(i)
	            t       = a(i)(j)
		        for (k <- 0 to i)
	                t -= l(i)(k) * u(k)(j)
	            u(i)(j) = t
	        }
	    }
		return (l, u)
    }

	// 行列の積
    def multiply(a:Array[Array[Double]], b:Array[Array[Double]]): Array[Array[Double]] = {
		var c = Array.ofDim[Double](N + 1, N + 1)

        for (i <- 0 to N) {
	        for (j <- 0 to N) {
				var s:Double = 0.0
		        for (k <- 0 to N)
	                s += a(i)(k) * b(k)(j)
	            c(i)(j) = s
	        }
        }
		return c
	}

    // 対角要素を表示
    def disp_eigenvalue(a:Array[Array[Double]]) {
        for (i <- 0 to N)
            print("%14.10f\t".format(a(i)(i)))
        println()
	}
}
