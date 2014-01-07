object Scala0602 {
    def main(args: Array[String]) {
		val a:Double = 0
		val b:Double = 1

		// ’†“_‘¥‚ÅÏ•ª
		var n:Int = 2
		for (j <- 1 to 10) {
		    var h:Double = (b - a) / n  
		    var s:Double = 0
		    var x:Double = a + (h / 2)
		    for (i <- 1 to n) {
		        s += f(x)
		        x += h
		    }
		    s *= h
		    n *= 2

		    // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
		    println("%3d : %13.10f, %13.10f".format(j, s, s - Math.PI))
		}
    }

	def f(x:Double):Double = {
	    4 / (1 + x * x)
	}
}
