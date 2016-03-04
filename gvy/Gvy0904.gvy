x = 2
printf ("%12.10f\n" , newton(x))

def newton(x0) {
    while (true) {
	    x1 = x0 - (f0(x0) / f1(x0))
        printf("%12.10f\t%13.10f\n", x1, x1 - Math.sqrt(2))

        if (Math.abs(x1 - x0) < 0.0000000001) break
        x0 = x1
    }
    x1
}

def f0(x) {
    x * x - 2
}

def f1(x) {
    2 * x
}
