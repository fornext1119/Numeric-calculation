object Scala1006 {
    val N = 3

    def main(args: Array[String]) {
		var a:Array[Array[Double]] = Array(Array(5,2,3,4), Array(2,10,6,7), Array(3,6,15,9), Array(4,7,9,20))
        var b:Array[Double] = Array(34,68,96,125)

        println("A")
		disp_matrix(a)
        println("B")
		disp_vector(b)
        println()

	    // 前進消去
	    forward_elimination(a,b)

        println("LL^T")
		disp_matrix(a)

	    // Ly=b から y を求める (前進代入)
        var y:Array[Double] = Array(0,0,0,0)
	    forward_substitution(a,b,y)

        println("Y")
	    disp_vector(y)

	    // L^Tx=y から x を求める (後退代入)
        var x:Array[Double] = Array(0,0,0,0)
	    backward_substitution(a,y,x)

        println("X")
		disp_vector(x)
    }
	// 前進消去
	def forward_elimination(a:Array[Array[Double]], b:Array[Double]) {
	    for (pivot <- 0 to N) {
	        var s:Double = 0;
	        for (col <- 0 to pivot - 1)
	            s += a(pivot)(col) * a(pivot)(col)
	        // ここで根号の中が負の値になると計算できない！
	        a(pivot)(pivot) = Math.sqrt(a(pivot)(pivot) - s)

	        for (row <- pivot + 1 to N) {
	            s = 0
	            for (col <- 0 to pivot - 1)
	                s += a(row)(col) * a(pivot)(col)
	            a(row)(pivot) =  (a(row)(pivot) - s) / a(pivot)(pivot)
	            a(pivot)(row) =  a(row)(pivot)
	        } 
	    }
	}
    // 前進代入
	def forward_substitution(a:Array[Array[Double]], b:Array[Double], y:Array[Double]) {
	    for (row <- 0 to N) {
	        for (col <- 0 to row - 1)
	            b(row) -= a(row)(col) * y(col)
	        y(row) = b(row) / a(row)(row)
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
