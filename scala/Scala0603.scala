object Scala0603 {
    def main(args: Array[String]) {
		val a:Double = 0
		val b:Double = 1

		// Simpson‘¥‚ÅÏ•ª
		var n:Int = 2
		for (j <- 1 to 5) {
		    var h:Double  = (b - a) / n  
		    var s2:Double = 0
		    var s4:Double = 0
		    var x:Double  = a + h
		    for (i <- 1 to (n / 2)) {
		        s4 += f(x)
		        x  += h
		        s2 += f(x)
		        x  += h
		    }
		    s2 = (s2 - f(b)) * 2 + f(a) + f(b)
		    s4 *= 4
		    var s:Double = (s2 + s4) * h / 3
		    n *= 2

		    // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
		    println("%3d : %13.10f, %13.10f".format(j, s, s - Math.PI))
		}
    }

	def f(x:Double):Double = {
	    4 / (1 + x * x)
	}
}
