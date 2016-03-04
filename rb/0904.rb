include Math

def f0(x)
    x * x - 2.0
end

def f1(x)
    2.0 * x
end

def newton(x0)
	while true
	    x1 = x0 - (f0(x0) / f1(x0))
	    printf("%12.10f\t%13.10f\n", x1, x1 - sqrt(2))

	    if (x1 - x0).abs < 0.0000000001
	        break
	    end
	  
	    x0 = x1
	end

	x1
end

x = 2.0
printf("%12.10f\n", newton(x))
