object Scala0604 {
    def main(args: Array[String]) {
		val a:Double = 0
		val b:Double = 1

		val t = Array.ofDim[Double](7, 7)

		// ‘äŒ`‘¥‚ÅÏ•ª
		var n:Int = 2
		for (i <- 1 to 6) {
		    var h:Double = (b - a) / n  
		    var s:Double = 0
		    var x:Double = a
		    for (j <- 1 to (n - 1)) {
		        x += h
		        s += f(x)
		    }
		    // Œ‹‰Ê‚ğ•Û‘¶
		    t(i)(1) = h * ((f(a) + f(b)) / 2 + s)
		    n *= 2
		}

		// Richardson‚Ì•âŠO–@
		n = 4
		for (j <- 2 to 6) {
		    for (i <- j to 6) {
		        t(i)(j) = t(i)(j - 1) + (t(i)(j - 1) - t(i - 1)(j - 1)) / (n - 1)
		        if (i == j) {
		            // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
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
