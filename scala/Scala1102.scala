object Scala1102 {
    val N = 3

	// 逆ベキ乗法で最小固有値を求める
    def main(args: Array[String]) {
		var a:Array[Array[Double]] = Array(Array(5.0, 4.0, 1.0, 1.0)
                                          ,Array(4.0, 5.0, 1.0, 1.0)
                                          ,Array(1.0, 1.0, 4.0, 2.0)
                                          ,Array(1.0, 1.0, 2.0, 4.0))

        var x:Array[Double] =              Array(1.0 ,0.0 ,0.0 ,0.0)

		// LU分解
	    forward_elimination(a)

        // 逆ベキ乗法
        val (lambda, x1) = inverse(a, x)

        println()
        println("eigenvalue")
        println("%14.10f".format(lambda))

        println("eigenvector")
        disp_vector(x1)
    }

    // 逆ベキ乗法
    def inverse(a:Array[Array[Double]], x:Array[Double]): (Double, Array[Double]) = {
        var x0:Array[Double] = normarize(x)
        var x1:Array[Double] = Array(0.0 ,0.0 ,0.0 ,0.0)
        var lambda:Double    = 0.0
        var e:Double         = 0.0
        var k = 1
		do {
            e  = x0.sum
            // １次元配列を表示
            print("%3d\t".format(k))
            disp_vector(x0)
            k += 1

            // Ly = b から y を求める (前進代入)
            var b = x0.clone
            var y:Array[Double] = Array(0.0 ,0.0 ,0.0 ,0.0)
            forward_substitution(a,y,b)
                            
            // Ux = y から x を求める (後退代入)
            x1 = Array(0.0 ,0.0 ,0.0 ,0.0)
            backward_substitution(a,x1,y)

            // 内積
            var (t1, t2) = (x0 zip x1).map(t => t match {case (f, s) => (s * s, s * f)}).unzip
            // 固有値
            lambda = t2.sum / t1.sum
            
            // 正規化 (ベクトル x1 の長さを１にする)
            x1 = normarize(x1)
            x0 = x1.clone
        } while (k <= 100 && Math.abs(e - x1.sum) >= 0.00000000001)
        
		return (lambda, x0)
    }

	// LU分解
	def forward_elimination(a:Array[Array[Double]]) {
	    for (pivot <- 0 to N - 1) {
	        for (row <- pivot + 1 to N) {
	            var s:Double = a(row)(pivot) / a(pivot)(pivot)
	            for (col <- pivot to N)
	                a(row)(col) -= a(pivot)(col)    * s // これが 上三角行列
	            a(row)(pivot) = s                       // これが 下三角行列
	        }
	    }
	}
    // 前進代入
	def forward_substitution(a:Array[Array[Double]], y:Array[Double], b:Array[Double]) {
	    for (row <- 0 to N) {
	        for (col <- 0 to row - 1)
	            b(row) -= a(row)(col) * y(col)
	        y(row) = b(row)
	    }
	}
	// 後退代入
	def backward_substitution(a:Array[Array[Double]], x:Array[Double], y:Array[Double]) {
	    for (row <- (0 to N).reverse) {
	        for (col <- (row + 1 to N).reverse)
	            y(row) -= a(row)(col) * x(col)
	        x(row) = y(row) / a(row)(row)
	    }
	}

	// １次元配列を表示
    def disp_vector(row:Array[Double]) = {
        row.foreach { col =>
            print("%14.10f\t".format(col))
        }
        println()
    }
	// 正規化 (ベクトルの長さを１にする)
    def normarize(x:Array[Double]):Array[Double] = {
        var s:Double = x.map(n => n * n).sum
	    s = Math.sqrt(s);
        x.map(n => n / s)
	}
}
