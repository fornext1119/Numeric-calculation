with TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0902 is

    function f(x:Long_Float) return Long_Float is
    begin
        return x * x - 2.0;
    end f;

    function falseposition(x0:Long_Float; x1:Long_Float) return Long_Float is
	    a:  Long_Float;
	    b:  Long_Float;
	    c:  Long_Float;
	    fc: Long_Float;
    begin
		a := x0;
		b := x1;
	    while true loop
	        -- “_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ðŒ‹‚Ô’¼ü‚Æ xŽ²‚ÌŒð“_
        	c := (a * f(b) - b * f(a)) / (f(b) - f(a));
	        Put(c,             Fore=>2, Aft=>10, Exp=>0);
	        Put(Ascii.HT);
	        Put(c - Sqrt(2.0), Fore=>2, Aft=>10, Exp=>0);
	        New_Line;

	        fc := f(c);
	        If Abs(fc) < 0.0000000001 then 
	            exit;
	        end if;
	        
	        if fc < 0.0 then
	            -- f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ð‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶Ý
	            a := c;
	        else
	            -- f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ð‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶Ý
	            b := c;
	        end if;
	    end loop;

		return c;
    end falseposition;

    a: Long_Float := 1.0;
    b: Long_Float := 2.0;
begin

    Put(falseposition(a, b), Fore=>2, Aft=>10, Exp=>0);
    New_Line;
end Ada0902;
