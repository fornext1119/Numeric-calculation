object Scala0906 {

    def main(args: Array[String]) {
        val x0 = 1.0
        val x1 = 2.0
        println("%12.10f".format(secant(x0, x1)))
    }

    def secant(x0:Double, x1:Double):Double = {
	    val x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
        println("%12.10f\t%13.10f".format(x2, x2 - Math.sqrt(2)))

        if (Math.abs(x2 - x1) < 0.0000000001)
            x2
        else
	        secant(x1, x2)
    }

    def f(x:Double) = {
        x * x - 2
    }
}
