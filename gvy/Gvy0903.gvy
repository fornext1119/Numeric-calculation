x = 1
printf ("%12.10f\n" , iterative(x))

def iterative(x0) {
    while (true) {
	    x1 = g(x0)
        printf("%12.10f\t%13.10f\n", x1, x1 - Math.sqrt(2))

        if (Math.abs(x1 - x0) < 0.0000000001) break
        x0 = x1
    }
    x1
}

def g(x) {
    (x / 2) + (1 / x)
}
