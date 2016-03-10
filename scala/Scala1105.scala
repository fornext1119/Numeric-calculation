object Scala105 {
    val N = 3

	// ヤコビ法で固有値を求める
    def main(args: Array[String]) {
		var a:Array[Array[Double]] = Array(Array(5.0, 4.0, 1.0, 1.0)
                                          ,Array(4.0, 5.0, 1.0, 1.0)
                                          ,Array(1.0, 1.0, 4.0, 2.0)
                                          ,Array(1.0, 1.0, 2.0, 4.0))

		var v:Array[Array[Double]] = Array(Array(1.0, 0.0, 0.0, 0.0)
                                          ,Array(0.0, 1.0, 0.0, 0.0)
                                          ,Array(0.0, 0.0, 1.0, 0.0)
                                          ,Array(0.0, 0.0, 0.0, 1.0))

        // ヤコビ法
        val (a1, v1) = jacobi(a, v)

        println()
        println("eigenvalue")
		disp_eigenvalue(a1)

        println()
        println("eigenvector")
        disp_eigenvector(v1)
    }

    // ヤコビ法
    def jacobi(a: => Array[Array[Double]], v: => Array[Array[Double]]): (Array[Array[Double]], Array[Array[Double]]) = {
        var max_val = 0.0
        var k = 1
		do {
	        // 最大値を探す
			var p = 0
			var q = 0
			max_val = 0.0
            for (i <- 0 to N) {
                for (j <- i + 1 to N) {
	                if (max_val < Math.abs(a(i)(j))) {
	                    max_val = Math.abs(a(i)(j))
	                    p = i
	                    q = j
					}
				}
			}

	        // θ を求める
	        var t = 0.0
	        if (Math.abs(a(p)(p) - a(q)(q)) < 0.00000000001) {
	            // a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
	            t = Math.PI / 4.0
	            if (a(p)(p) < 0)
	                t = -t
	        } else {
	            // a_{pp} ≠ a_{qq} のとき
	            t = Math.atan(2.0 * a(p)(q) / (a(p)(p) - a(q)(q))) / 2.0
	        }

	        // θ を使って 行列 U を作成し、A = U^t × A × U
	        val c = Math.cos(t)
	        val s = Math.sin(t)
	        // U^t × A
	        var t1 = 0.0
	        var t2 = 0.0
            for (i <- 0 to N) {
	            t1      =  a(p)(i) * c + a(q)(i) * s
	            t2      = -a(p)(i) * s + a(q)(i) * c
	            a(p)(i) = t1
	            a(q)(i) = t2
	            // 固有ベクトル
	            t1      =  v(p)(i) * c + v(q)(i) * s
	            t2      = -v(p)(i) * s + v(q)(i) * c
	            v(p)(i) = t1
	            v(q)(i) = t2
	        }
	        // A × U
            for (i <- 0 to N) {
	            t1      =  a(i)(p) * c + a(i)(q) * s
	            t2      = -a(i)(p) * s + a(i)(q) * c
	            a(i)(p) = t1
	            a(i)(q) = t2
	        }

	        // 対角要素を表示
            print("%3d\t".format(k))
	        disp_eigenvalue(a)
			k += 1

        } while (k <= 100 && max_val >= 0.00000000001)
        
		return (a, v)
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
	    s = Math.sqrt(s)
        x.map(n => n / s)
	}
    // 対角要素を表示
    def disp_eigenvalue(a:Array[Array[Double]]) {
        for (i <- 0 to N)
            print("%14.10f\t".format(a(i)(i)))
        println()
	}
    // 固有ベクトルを表示
    def disp_eigenvector(matrix:Array[Array[Double]]) {
        for (i <- 0 to N) {
            var row = new Array[Double](N + 1)
            for (j <- 0 to N)
                row(j) = matrix(i)(j)
	        disp_vector(normarize(row))
		}
    }
}
