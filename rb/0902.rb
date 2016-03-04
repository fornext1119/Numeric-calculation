include Math

def f(x)
    x * x - 2.0
end

def falseposition(a, b)
	while true
	    # “_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ğŒ‹‚Ô’¼ü‚Æ x²‚ÌŒğ“_
	    c  = (a * f(b) - b * f(a)) / (f(b) - f(a))
	    printf("%12.10f\t%13.10f\n", c, c - sqrt(2))

	    fc = f(c)
	    if fc.abs < 0.0000000001
	        break
	    end
	  
	    if fc < 0
	        # f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
	        a = c
	    else
	        # f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
	        b = c
	    end
	end

	c
end

a = 1.0
b = 2.0
printf("%12.10f\n", falseposition(a, b))
