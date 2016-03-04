# coding: Shift_JIS

import math

def f0(x):
    return x * x - 2.0

def f1(x):
    return 2.0 * x

def f2(x):
    return 2.0

def bailey(x0):
	while True:
	    x1 = x0 - (f0(x0) / (f1(x0) - (f0(x0) * f2(x0) / (2 * f1(x0)))))
	    print "%12.10f\t%13.10f" % (x1, x1 - math.sqrt(2))

	    if (abs(x1 - x0) < 0.0000000001):
	        break
	    x0 = x1

	return x1

x = 2.0
print "%12.10f" % bailey(x)
