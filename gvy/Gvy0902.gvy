a = 1
b = 2
printf ("%12.10f\n" , falseposition(a, b))

def falseposition(a, b) {
    while (true) {
	    // 点 (a,f(a)) と 点 (b,f(b)) を結ぶ直線と x軸の交点
	    c  = (a * f(b) - b * f(a)) / (f(b) - f(a))
        printf("%12.10f\t%13.10f\n", c, c - Math.sqrt(2))

        fc = f(c)
        if (Math.abs(fc) < 0.0000000001) break

        if (fc < 0) {
            // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
            a = c
        } else {
            // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
            b = c
        }
    }
    c
}

def f(x) {
    x * x - 2
}
