object Scala0601 {
    def main(args: Array[String]) {
		val a:Double = 0
		val b:Double = 1

		// 台形則で積分
		var n:Int = 2
		for (j <- 1 to 10) {
		    var h:Double = (b - a) / n  
		    var s:Double = 0
		    var x:Double = a
		    for (i <- 1 to (n - 1)) {
		        x += h
		        s += f(x)
		    }
		    s = h * ((f(a) + f(b)) / 2 + s)
		    n *= 2

		    // 結果を π と比較
		    println("%3d : %13.10f, %13.10f".format(j, s, s - Math.PI))
		}
    }

	def f(x:Double):Double = {
	    4 / (1 + x * x)
	}
}
