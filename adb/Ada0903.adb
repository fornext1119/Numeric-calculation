with TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0903 is

    function g(x:Long_Float) return Long_Float is
    begin
        return (x / 2.0) + (1.0 / x);
    end g;

    function iterative(x:Long_Float) return Long_Float is
	    x0: Long_Float;
	    x1: Long_Float;
    begin
		x0 := x;
	    while true loop
        	x1 := g(x0);
	        Put(x1,             Fore=>2, Aft=>10, Exp=>0);
	        Put(Ascii.HT);
	        Put(x1 - Sqrt(2.0), Fore=>2, Aft=>10, Exp=>0);
	        New_Line;

	        If Abs(x1 - x0) < 0.0000000001 then 
	            exit;
	        end if;
	        x0 := x1;
	    end loop;

		return x1;
    end iterative;

    x: Long_Float := 1.0;
begin
    Put(iterative(x), Fore=>2, Aft=>10, Exp=>0);
    New_Line;
end Ada0903;
