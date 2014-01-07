object Scala0703 {
    // データ点の数 - 1
    val N = 6 

    def main(args: Array[String]) {
        // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
        val x = (0 to N).map(_ * 1.5 - 4.5)
        val y = x.map(f)

	    // 差分商の表を作る
        val d = Array.ofDim[Double](N + 1, N + 1)
	    for (j <- 0 to N)
	        d(0)(j) = y(j)

	    for (i <- 1 to N) {
		    for (j <- 0 to N - i)
	            d(i)(j) = (d(i-1)(j+1) - d(i-1)(j)) / (x(j+i) - x(j))
	    }

	    // ｎ階差分商
        val a = (0 to N).map(d(_)(0))

        // 0.5刻みで 与えられていない値を補間
        val d1 = (0 to 18).map(_ * 0.5 - 4.5)
        val d2 = d1.map(f)
        val d3 = d1.map(newton(_, x, a))

        (d1 zip d2 zip d3).foreach { 
            case ((d1, d2), d3) => 
                println("%5.2f\t%8.5f\t%8.5f\t%8.5f".format(d1, d2, d3, d2 - d3))
        }
    }

    // 元の関数
    def f(x:Double) = {
        x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2)
    }

	// Newton (ニュートン) 補間
    def newton(d:Double, x:IndexedSeq[Double], a:IndexedSeq[Double]) = {
        var sum_list = List(a(0))
        for (i <- 1 to N) {
            var prod_list = List(a(i))
            for (j <- 0 to i - 1) {
                prod_list = (d - x(j))::prod_list
            }
            sum_list = (prod_list.product)::sum_list
        }
        sum_list.sum
    }
}
