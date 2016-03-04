object Scala0701 {
    // データ点の数 - 1
    val N = 6 

    def main(args: Array[String]) {
        // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
        val x = (0 to N).map(_ * 1.5 - 4.5)
        val y = x.map(f)

        // 0.5刻みで 与えられていない値を補間
        val d1 = (0 to 18).map(_ * 0.5 - 4.5)
        val d2 = d1.map(f)
        val d3 = d1.map(lagrange(_, x, y))

        (d1 zip d2 zip d3).foreach { 
            case ((d1, d2), d3) => 
                println("%5.2f\t%8.5f\t%8.5f\t%8.5f".format(d1, d2, d3, d2 - d3))
        }
    }

    // 元の関数
    def f(x:Double) = {
        x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2)
    }

    // Lagrange (ラグランジュ) 補間
    def lagrange(d:Double, x:IndexedSeq[Double], y:IndexedSeq[Double]) = {
        var sum_list = List[Double](0)
        for (i <- 0 to N) {
            var prod_list = List(y(i))
            for (j <- 0 to N) {
                if (i != j) {
                    prod_list = ((d - x(j)) / (x(i) - x(j)))::prod_list
                }
            }
            sum_list = prod_list.product::sum_list
        }
        sum_list.sum
    }
}
