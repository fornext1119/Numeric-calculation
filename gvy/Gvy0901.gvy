a = 1
b = 2
printf ("%12.10f\n" , bisection(a, b))

def bisection(a, b) {
    while (true) {
        // ��� (a, b) �̒��_ c = (a + b) / 2
        c = (a + b) / 2
        printf("%12.10f\t%13.10f\n", c, c - Math.sqrt(2))

        fc = f(c)
        if (Math.abs(fc) < 0.0000000001) break

        if (fc < 0) {
            // f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ���
            a = c
        } else {
            // f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ���
            b = c
        }
    }
    c
}

def f(x) {
    x * x - 2
}
