object Scala0904 {

    def main(args: Array[String]) {
        val x = 2.0
        println("%12.10f".format(newton(x)))
    }

    def newton(x0:Double):Double = {
	    val x1 = x0 - (f0(x0) / f1(x0))
        println("%12.10f\t%13.10f".format(x1, x1 - Math.sqrt(2)))

        if (Math.abs(x1 - x0) < 0.0000000001)
            x1
        else
	        newton(x1)
    }

    def f0(x:Double) = {
        x * x - 2
    }
    def f1(x:Double) = {
        2 * x
    }
}
