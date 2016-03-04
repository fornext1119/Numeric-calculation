object Scala1002 {
    val N = 3

    def main(args: Array[String]) {
		var a:Array[Array[Double]] = Array(Array(9,2,1,1),Array(2,8,-2,1),Array(-1,-2,7,-2),Array(1,-1,-2,6))
        var b:Array[Double] = Array(20,16,8,17)
        var c:Array[Double] = Array(0,0,0,0)

        // ガウス・ザイデル法
        gauss(a,b,c)

        println("X")
		disp_vector(c)
    }
    // ガウス・ザイデル法
    def gauss(a:Array[Array[Double]], b:Array[Double], x0:Array[Double]) = {
		var finish:Boolean = false
        while (!finish) {
			finish = true

            for (i <- 0 to N) {
                var x1:Double = 0
                for (j <- 0 to N)
                    if (j != i)
                        x1 += a(i)(j) * x0(j)

                x1 = (b(i) - x1) / a(i)(i)
                if (Math.abs(x1 - x0(i)) > 0.0000000001) 
					finish = false
                x0(i) = x1
            }

            if (!finish) 
				disp_vector(x0)
        }
	}

	// １次元配列を表示
    def disp_vector(row:Array[Double]) = {
        row.foreach { col =>
            print("%14.10f\t".format(col))
        }
        println()
    }
}
