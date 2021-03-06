a = 1
b = 2
printf ("%12.10f\n" , bisection(a, b))

def bisection(a, b) {
    while (true) {
        // 区間 (a, b) の中点 c = (a + b) / 2
        c = (a + b) / 2
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
