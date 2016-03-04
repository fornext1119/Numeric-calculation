with TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0906 is

    function f(x:Long_Float) return Long_Float is
    begin
        return x * x - 2.0;
    end f;

    function secant(a:Long_Float; b:Long_Float) return Long_Float is
	    x0: Long_Float;
	    x1: Long_Float;
	    x2: Long_Float;
    begin
		x0 := a;
		x1 := b;
	    while true loop
			x2 := x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
	        Put(x1,             Fore=>2, Aft=>10, Exp=>0);
	        Put(Ascii.HT);
	        Put(x1 - Sqrt(2.0), Fore=>2, Aft=>10, Exp=>0);
	        New_Line;

	        If Abs(x1 - x0) < 0.0000000001 then 
	            exit;
	        end if;
	        x0 := x1;
	        x1 := x2;
	    end loop;

		return x2;
    end secant;

    x0: Long_Float := 1.0;
    x1: Long_Float := 2.0;
begin
    Put(secant(x0, x1), Fore=>2, Aft=>10, Exp=>0);
    New_Line;
end Ada0906;
