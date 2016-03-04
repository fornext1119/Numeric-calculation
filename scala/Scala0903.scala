object Scala0903 {

    def main(args: Array[String]) {
        val x = 1.0
        println("%12.10f".format(iterative(x)))
    }

    def iterative(x0:Double):Double = {
	    val x1 = g(x0)
        println("%12.10f\t%13.10f".format(x1, x1 - Math.sqrt(2)))

        if (Math.abs(x1 - x0) < 0.0000000001)
            x1
        else
	        iterative(x1)
    }

    def g(x:Double) = {
        (x / 2) + (1 / x)
    }
}
