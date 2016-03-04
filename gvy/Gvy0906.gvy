x0 = 1
x1 = 2
printf ("%12.10f\n" , secant(x0, x1))

def secant(x0, x1) {
    while (true) {
		x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
        printf("%12.10f\t%13.10f\n", x2, x2 - Math.sqrt(2))

        if (Math.abs(x2 - x1) < 0.0000000001) break
        x0 = x1
        x1 = x2
    }
    x2
}

def f(x) {
    x * x - 2
}
