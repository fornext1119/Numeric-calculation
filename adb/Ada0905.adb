with TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0905 is

    function f0(x:Long_Float) return Long_Float is
    begin
        return x * x - 2.0;
    end f0;

    function f1(x:Long_Float) return Long_Float is
    begin
        return 2.0 * x;
    end f1;

    function f2(x:Long_Float) return Long_Float is
    begin
        return 2.0;
    end f2;

    function bailey(x:Long_Float) return Long_Float is
	    x0: Long_Float;
	    x1: Long_Float;
    begin
		x0 := x;
	    while true loop
        	x1 := x0 - (f0(x0) / (f1(x0) - (f0(x0) * f2(x0) / (2.0 * f1(x0)))));
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
    end bailey;

    x: Long_Float := 2.0;
begin
    Put(bailey(x), Fore=>2, Aft=>10, Exp=>0);
    New_Line;
end Ada0905;
