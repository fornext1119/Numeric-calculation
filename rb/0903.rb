include Math

def g(x)
    (x / 2.0) + (1.0 / x)
end

def iterative(x0)
	while true
	    x1 = g(x0)
	    printf("%12.10f\t%13.10f\n", x1, x1 - sqrt(2))

	    if (x1 - x0).abs < 0.0000000001
	        break
	    end
	  
	    x0 = x1
	end

	x1
end

x = 1.0
printf("%12.10f\n", iterative(x))
