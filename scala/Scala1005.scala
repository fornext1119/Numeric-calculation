object Scala1005 {
    val N = 3

    def main(args: Array[String]) {
		var a:Array[Array[Double]] = Array(Array(-1,-2,7,-2),Array(1,-1,-2,6),Array(9,2,1,1),Array(2,8,-2,1))
        var b:Array[Double] = Array(8,17,20,16)

	    // ピボット選択
	    pivoting(a,b)

        println("pivoting")
        println("A")
		disp_matrix(a)
        println("B")
		disp_vector(b)
        println()

	    // 前進消去
	    forward_elimination(a,b)

        println("LU")
		disp_matrix(a)

	    // Ly=b から y を求める (前進代入)
        var y:Array[Double] = Array(0,0,0,0)
	    forward_substitution(a,b,y)

        println("Y")
	    disp_vector(y)

	    // Ux=y から x を求める (後退代入)
        var x:Array[Double] = Array(0,0,0,0)
	    backward_substitution(a,y,x)

        println("X")
		disp_vector(x)
    }
	// 前進消去
	def forward_elimination(a:Array[Array[Double]], b:Array[Double]) {
	    for (pivot <- 0 to N - 1) {
	        for (row <- pivot + 1 to N) {
	            var s:Double = a(row)(pivot) / a(pivot)(pivot)
	            for (col <- pivot to N)
	                a(row)(col) -= a(pivot)(col)    * s // これが 上三角行列
	            a(row)(pivot) = s                       // これが 下三角行列
	            // b(row)     -= b(pivot)           * s // この値は変更しない
	        }
	    }
	}
    // 前進代入
	def forward_substitution(a:Array[Array[Double]], b:Array[Double], y:Array[Double]) {
	    for (row <- 0 to N) {
	        for (col <- 0 to row - 1)
	            b(row) -= a(row)(col) * y(col)
	        y(row) = b(row)
	    }
	}
	// 後退代入
	def backward_substitution(a:Array[Array[Double]], y:Array[Double], x:Array[Double]) {
	    for (row <- (0 to N).reverse) {
	        for (col <- (row + 1 to N).reverse)
	            y(row) -= a(row)(col) * x(col)
	        x(row) = y(row) / a(row)(row)
	    }
	}
	// ピボット選択
	def pivoting(a:Array[Array[Double]], b:Array[Double]) {
	    for (pivot <- 0 to N) {
	        // 各列で 一番値が大きい行を 探す
	        var max_row:Integer =   pivot
	        var max_val:Double  =   0
	        for (row <- pivot to N) {
	            if (Math.abs(a(row)(pivot)) > max_val) {
	                // 一番値が大きい行
	                max_val =   Math.abs(a(row)(pivot))
	                max_row =   row
	            }
	        }

	        // 一番値が大きい行と入れ替え
	        if (max_row != pivot) {
	            var tmp:Double = 0
	            for (col <- 0 to N) {
	                tmp             =   a(max_row)(col)
	                a(max_row)(col) =   a(pivot)(col)
	                a(pivot)(col)   =   tmp
	            }
	            tmp         =   b(max_row)
	            b(max_row)  =   b(pivot)
	            b(pivot)    =   tmp
	        }
	    }
	}

	// １次元配列を表示
    def disp_vector(row:Array[Double]) = {
        row.foreach { col =>
            print("%14.10f\t".format(col))
        }
        println()
    }
	// ２次元配列を表示
    def disp_matrix(matrix:Array[Array[Double]]) = {
        matrix.foreach { row =>
	        row.foreach { col =>
	            print("%14.10f\t".format(col))
	        }
	        println()
        }
    }
}
