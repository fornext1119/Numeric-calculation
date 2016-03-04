include Math

def f(x)
    x * x - 2.0
end

def secant(x0, x1)
	while true
	    x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
	    printf("%12.10f\t%13.10f\n", x2, x2 - sqrt(2))

	    if (x2 - x1).abs < 0.0000000001
	        break
	    end
	  
	    x0 = x1
	    x1 = x2
	end

	x2
end

x0 = 1.0
x1 = 2.0
printf("%12.10f\n", secant(x0, x1))
