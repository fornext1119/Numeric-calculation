with Text_IO, Ada.Long_Float_Text_IO, Ada.Integer_Text_IO, Ada.Numerics;
use  Text_IO, Ada.Long_Float_Text_IO, Ada.Integer_Text_IO, Ada.Numerics;

procedure Ada0604 is
    a : Constant Long_Float := 0.0;
    b : Constant Long_Float := 1.0;

    h, s, x : Long_Float;
    n : Integer;
    t : array (1..6, 1..6) of Long_Float;

    function f(x:Long_Float) return Long_Float is
    begin
        return 4.0 / (1.0 + x * x);
    end f;

begin
    -- ‘äŒ`‘¥‚ÅÏ•ª
    n := 2;
    for i in 1..6 loop
        h := (b - a) / Long_Float(n);
        s := 0.0;
        x := a;
        for j in 1..(n - 1) loop
            x := x + h;
            s := s + f(x);
        end loop;
        -- Œ‹‰Ê‚ð•Û‘¶
        t(i,1) := h * ((f(a) + f(b)) / 2.0 + s);
        n := n * 2;
    end loop;

    -- Richardson‚Ì•âŠO–@
    n := 4;
    for j in 2..6 loop
        for i in j..6 loop
            t(i,j) := t(i, j - 1) + (t(i, j - 1) - t(i - 1, j - 1)) / Long_Float(n - 1);
            if i = j then
		        -- Œ‹‰Ê‚ð ƒÎ ‚Æ”äŠr
		        Put(j,                        Width=> 2);
		        Put(" : ");
		        Put(t(i,j) ,                  Fore=>3, Aft=>10, Exp=>0);
		        Put(", ");
		        Put(t(i,j) - Ada.Numerics.Pi, Fore=>3, Aft=>10, Exp=>0);
		        New_Line;
            end if;
    	end loop;
        n := n * 4;
    end loop;
end Ada0604;
