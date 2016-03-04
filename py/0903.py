# coding: Shift_JIS

import math

def g(x):
    return (x / 2.0) + (1.0 / x)

def iterative(x0):
	while True:
	    x1 = g(x0)
	    print "%12.10f\t%13.10f" % (x1, x1 - math.sqrt(2))

	    if (abs(x1 - x0) < 0.0000000001):
	        break
	    x0 = x1

	return x1

x = 1.0
print "%12.10f" % iterative(x)
