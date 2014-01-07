object Scala0704 {
    // データ点の数 - 1
    val N   =  6 
    val Nx2 = 13

    def main(args: Array[String]) {
        // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
        val x  = (0 to N).map(_ * 1.5 - 4.5)
        val y  = x.map(f)
        val yd = x.map(fd)

	    // 差分商の表を作る
        val z = (0 to Nx2).map(_ / 2).map(x(_))
        val d = Array.ofDim[Double](Nx2 + 1, Nx2 + 1)
	    for (i <- 0 to Nx2)
	        d(0)(i) = y(i / 2)

	    for (i <- 1 to Nx2) {
		    for (j <- 0 to Nx2 - i)
	            if (i == 1 && j % 2 == 0)
	                d(i)(j) = yd(j / 2)
	            else
	            	d(i)(j) = (d(i-1)(j+1) - d(i-1)(j)) / (z(j+i) - z(j))
	    }

	    // ｎ階差分商
        val a = (0 to Nx2).map(d(_)(0))

        // 0.5刻みで 与えられていない値を補間
        val d1 = (0 to 18).map(_ * 0.5 - 4.5)
        val d2 = d1.map(f)
        val d3 = d1.map(hermite(_, z, a))

        (d1 zip d2 zip d3).foreach { 
            case ((d1, d2), d3) => 
                println("%5.2f\t%8.5f\t%8.5f\t%8.5f".format(d1, d2, d3, d2 - d3))
        }
    }

    // 元の関数
    def f(x:Double) = {
        x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2)
    }
	// 導関数
    def fd(x:Double) = {
	    1 - Math.pow(x,2) / 2 + Math.pow(x,4) / (4 * 3 * 2)
	}

	// Hermite (エルミート) 補間
    def hermite(d:Double, z:IndexedSeq[Double], a:IndexedSeq[Double]) = {
        var sum_list = List(a(0))
        for (i <- 1 to Nx2) {
            var prod_list = List(a(i))
            for (j <- 0 to i - 1) {
                prod_list = (d - z(j))::prod_list
            }
            sum_list = (prod_list.product)::sum_list
        }
        sum_list.sum
    }
}
