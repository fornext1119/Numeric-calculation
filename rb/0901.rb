include Math

def f(x)
    x * x - 2.0
end

def bisection(a, b)
	while true
	    # 区間 (a, b) の中点 c = (a + b) / 2
	    c = (a + b) / 2
	    printf("%12.10f\t%13.10f\n", c, c - sqrt(2))

	    fc = f(c)
	    if fc.abs < 0.0000000001
	        break
	    end
	  
	    if fc < 0
	        # f(c) < 0 であれば, 解は区間 (c, b) の中に存在
	        a = c
	    else
	        # f(c) > 0 であれば, 解は区間 (a, c) の中に存在
	        b = c
	    end
	end

	c
end

a = 1.0
b = 2.0
printf("%12.10f\n", bisection(a, b))
