object Scala0604 {
    def main(args: Array[String]) {
		val a:Double = 0
		val b:Double = 1

		val t = Array.ofDim[Double](7, 7)

		// 台形則で積分
		var n:Int = 2
		for (i <- 1 to 6) {
		    var h:Double = (b - a) / n  
		    var s:Double = 0
		    var x:Double = a
		    for (j <- 1 to (n - 1)) {
		        x += h
		        s += f(x)
		    }
		    // 結果を保存
		    t(i)(1) = h * ((f(a) + f(b)) / 2 + s)
		    n *= 2
		}

		// Richardsonの補外法
		n = 4
		for (j <- 2 to 6) {
		    for (i <- j to 6) {
		        t(i)(j) = t(i)(j - 1) + (t(i)(j - 1) - t(i - 1)(j - 1)) / (n - 1)
		        if (i == j) {
		            // 結果を π と比較
		            println("%3d : %13.10f, %13.10f".format(j, t(i)(j), t(i)(j) - Math.PI))
		        }
		    }
		    n *= 4
		}
    }

	def f(x:Double):Double = {
	    4 / (1 + x * x)
	}
}
