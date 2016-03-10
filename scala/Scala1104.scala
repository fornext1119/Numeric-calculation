object Scala1104 {
    val N = 3

	// QR分解で固有値を求める
    def main(args: Array[String]) {
		var a:Array[Array[Double]] = Array(Array(5.0, 4.0, 1.0, 1.0)
                                          ,Array(4.0, 5.0, 1.0, 1.0)
                                          ,Array(1.0, 1.0, 4.0, 2.0)
                                          ,Array(1.0, 1.0, 2.0, 4.0))

        var e:Double = 0.0
        var k = 1
		do {
		    // QR分解
			var (q, r) = decomp(a)
	        // 行列の積
	        a = multiply(r, q)
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

	// QR分解
    def decomp(a:Array[Array[Double]]): (Array[Array[Double]], Array[Array[Double]]) = {
		var x = new Array[Double](N + 1)
		var q = Array.ofDim[Double](N + 1, N + 1)
		var r = Array.ofDim[Double](N + 1, N + 1)

        for (k <- 0 to N) {
	        for (i <- 0 to N)
	            x(i) = a(i)(k)

            for (j <- 0 to k - 1) {
				var t:Double = 0.0
		        for (i <- 0 to N)
	                t += a(i)(k) * q(i)(j)

	            r(j)(k) = t
	            r(k)(j) = 0.0
		        for (i <- 0 to N)
            		x(i) -= t * q(i)(j)
			}

			r(k)(k) = Math.sqrt(x.map(n => n * n).sum)
	        for (i <- 0 to N)
	            q(i)(k) = x(i) / r(k)(k)
	    }
		return (q, r)
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
