# coding: Shift_JIS

import math

def f(x):
    return x * x - 2.0

def secant(x0, x1):
	while True:
	    x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
	    print "%12.10f\t%13.10f" % (x2, x2 - math.sqrt(2))

	    if (abs(x2 - x1) < 0.0000000001):
	        break
	    x0 = x1
	    x1 = x2

	return x2

x0 = 1.0
x1 = 2.0
print "%12.10f" % secant(x0, x1)
