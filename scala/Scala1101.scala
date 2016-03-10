object Scala1101 {
    val N = 3

    // ベキ乗法で最大固有値を求める
    def main(args: Array[String]) {
		var a:Array[Array[Double]] = Array(Array(5.0, 4.0, 1.0, 1.0)
                                          ,Array(4.0, 5.0, 1.0, 1.0)
                                          ,Array(1.0, 1.0, 4.0, 2.0)
                                          ,Array(1.0, 1.0, 2.0, 4.0))

        var x:Array[Double] =              Array(1.0 ,0.0 ,0.0 ,0.0)

        // ベキ乗法
        val (lambda, x1) = power(a, x)

        println()
        println("eigenvalue")
        println("%14.10f".format(lambda))

        println("eigenvector")
        disp_vector(x1)
    }

    // ベキ乗法
    def power(a:Array[Array[Double]], x:Array[Double]): (Double, Array[Double]) = {
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

            // 行列の積 x1 = A × x0 
            x1 = Array(0.0 ,0.0 ,0.0 ,0.0)
            for (i <- 0 to N)
                for (j <- 0 to N)
                    x1(i) += a(i)(j) * x0(j)

            // 内積
            var (t1, t2) = (x0 zip x1).map(t => t match {case (f, s) => (s * s, s * f)}).unzip
            // 固有値
            lambda = t1.sum / t2.sum
            
            // 正規化 (ベクトル x1 の長さを１にする)
            x1 = normarize(x1)
            x0 = x1.clone
        } while (k <= 100 && Math.abs(e - x1.sum) >= 0.00000000001)
        
		return (lambda, x0)
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
