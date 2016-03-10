object Scala105 {
    val N = 3

    // ハウスホルダー変換とQR分解で固有値を求める
    def main(args: Array[String]) {
        var a:Array[Array[Double]] = Array(Array(5.0, 4.0, 1.0, 1.0)
                                          ,Array(4.0, 5.0, 1.0, 1.0)
                                          ,Array(1.0, 1.0, 4.0, 2.0)
                                          ,Array(1.0, 1.0, 2.0, 4.0))

        // ハウスホルダー変換
        var (d, e) = tridiagonalize(a)

        // QR分解
        decomp(a, d, e)

        println()
        println("eigenvalue")
        disp_vector(d)

        println()
        println("eigenvector")
        disp_matrix(a)
    }

    // ハウスホルダー変換
    def tridiagonalize(a: => Array[Array[Double]]): (Array[Double], Array[Double]) = {
        var w = new Array[Double](N + 1)
        var v = new Array[Double](N + 1)

        var d = new Array[Double](N + 1)
        var e = new Array[Double](N + 1)

        for (k <- 0 to N - 2) {
            d(k) = a(k)(k)

            var t = 0.0
            for (i <- k + 1 to N) {
                w(i) =  a(i)(k)
                t    += w(i) * w(i)
            }
            var s = Math.sqrt(t)
            if (w(k + 1) < 0)
                s = -s

            if (Math.abs(s) < 0.00000000001)
                e(k + 1) = 0.0
            else {
                e(k + 1)  = -s
                w(k + 1) +=  s
                s = 1 / Math.sqrt(w(k + 1) * s)
                for (i <- k + 1 to N)
                    w(i) *= s

                for (i <- k + 1 to N) {
                    s = 0.0
                    for (j <- k + 1 to N) {
                        if (j <= i)
                            s += a(i)(j) * w(j)
                        else
                            s += a(j)(i) * w(j)
                    }
                    v(i) = s
                }

                s = 0.0
                for (i <- k + 1 to N)
                    s += w(i) * v(i)
                s /= 2.0
                for (i <- k + 1 to N)
                    v(i) -= s * w(i)
                for (i <- k + 1 to N)
                    for (j <- k + 1 to i)
                        a(i)(j) -= w(i) * v(j) + w(j) * v(i)
                // 次の行は固有ベクトルを求めないなら不要
                for (i <- k + 1 to N)
                    a(i)(k) = w(i)
            } 
        }

        d(N - 1) = a(N - 1)(N - 1)
        d(N    ) = a(N    )(N    )
        
        e(0)     = 0.0 
        e(N    ) = a(N    )(N - 1)

        // 次の行は固有ベクトルを求めないなら不要
        for (k <- (N to 0 by -1)) {
            w = Array(0.0, 0.0, 0.0, 0.0)
            if (k < N - 1) {
                for (i <- k + 1 to N)
                    w(i) = a(i)(k)
                for (i <- k + 1 to N) {
                    var s = 0.0
                    for (j <- k + 1 to N)
                        s += a(i)(j) * w(j)
                    v(i) = s
                }
                for (i <- k + 1 to N)
                    for (j <- k + 1 to N)
                        a(i)(j) -= v(i) * w(j)
            }
            for (i <- 0 to N)
                a(i)(k) = 0.0
            a(k)(k) = 1.0
        }

        return (d, e)
    }

    // QR分解
    def decomp(a: => Array[Array[Double]], d: => Array[Double], e: => Array[Double]) {
        e(0) = 1.0
        var h = N
        while (Math.abs(e(h)) < 0.00000000001) h -= 1

        while (h > 0) {
            e(0) = 0.0
            var l = h - 1
            while (Math.abs(e(l)) >= 0.00000000001) l -= 1

            var j = 1
            do {
                var w = (d(h - 1) - d(h)) / 2.0
                var s = Math.sqrt(w * w + e(h) * e(h))
                if (w < 0.0)
                    s = -s

                var x = d(l) - d(h) + e(h) * e(h) / (w + s)
                var y = e(l + 1)
                var z = 0.0
                var t = 0.0
                var u = 0.0
                for (k <- l to h - 1) {
                    if (Math.abs(x) >= Math.abs(y)) {
                        t = -y / x
                        u = 1 / Math.sqrt(t * t + 1.0)
                        s = t * u
                    } else {
                        t = -x / y
                        s = 1 / Math.sqrt(t * t + 1.0)
                        if (t < 0)
                            s = -s
                        u = t * s
                    }
                    w = d(k) - d(k + 1)
                    t = (w * s + 2 * u * e(k + 1)) * s
                    d(k    ) = d(k    ) - t
                    d(k + 1) = d(k + 1) + t
                    e(k    ) = u * e(k) - s * z
                    e(k + 1) = e(k + 1) * (u * u - s * s) + w * s * u

                    // 次の行は固有ベクトルを求めないなら不要
                    for (i <- 0 to N) {
                        x = a(k    )(i)
                        y = a(k + 1)(i)
                        a(k    )(i) = u * x - s * y
                        a(k + 1)(i) = s * x + u * y
                    }

                    if (k < N - 2) {
                        x = e(k + 1)
                        y = -s * e(k + 2)
                        z = y
                        e(k + 2) = u * e(k + 2)
                    }
                }

                print("%3d\t".format(j))
                j += 1
                disp_vector(d)

            } while (j <= 100 && Math.abs(e(h)) >= 0.00000000001)

            e(0) = 1.0
            while (Math.abs(e(h)) < 0.00000000001) h -= 1
        }

        // 次の行は固有ベクトルを求めないなら不要
        for (k <- 0 to N - 1) {
            var l = k
            for (i <- k + 1 to N)
                if (d(i) > d(l))
                    l = i

            var t = d(k)
            d(k) = d(l)
            d(l) = t

            for (i <- 0 to N) {
                t       = a(k)(i)
                a(k)(i) = a(l)(i)
                a(l)(i) = t
            }
        }
    }

    // １次元配列を表示
    def disp_vector(row:Array[Double]) = {
        row.foreach { col =>
            print("%14.10f\t".format(col))
        }
        println()
    }
    // ２次元配列を表示
    def disp_matrix(matrix:Array[Array[Double]]) {
        for (row <- 0 to N) {
            for (col <- 0 to N)
                print("%14.10f\t".format(matrix(row)(col)))
            println()
        }
    }
}
