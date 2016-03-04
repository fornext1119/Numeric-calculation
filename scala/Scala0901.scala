object Scala0901 {

    def main(args: Array[String]) {
        val a = 1.0
        val b = 2.0
        println("%12.10f".format(bisection(a, b)))
    }

    def bisection(a:Double, b:Double):Double = {
        // 区間 (a, b) の中点 c = (a + b) / 2
        val c = (a + b) / 2
        println("%12.10f\t%13.10f".format(c, c - Math.sqrt(2)))

        val fc = f(c)
        if (Math.abs(fc) < 0.0000000001)
            c
        else {
	        if (fc < 0) {
	            // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
	            bisection(c, b)
	        } else {
	            // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
	            bisection(a, c)
	        }
        }
    }

    def f(x:Double) = {
        x * x - 2
    }
}
