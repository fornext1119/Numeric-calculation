object Scala0902 {

    def main(args: Array[String]) {
        val a = 1.0
        val b = 2.0
        println("%12.10f".format(falseposition(a, b)))
    }

    def falseposition(a:Double, b:Double):Double = {
	    // 点 (a,f(a)) と 点 (b,f(b)) を結ぶ直線と x軸の交点
	    val c = (a * f(b) - b * f(a)) / (f(b) - f(a))
        println("%12.10f\t%13.10f".format(c, c - Math.sqrt(2)))

        val fc = f(c)
        if (Math.abs(fc) < 0.0000000001)
            c
        else {
	        if (fc < 0) {
	            // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
	            falseposition(c, b)
	        } else {
	            // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
	            falseposition(a, c)
	        }
        }
    }

    def f(x:Double) = {
        x * x - 2
    }
}
