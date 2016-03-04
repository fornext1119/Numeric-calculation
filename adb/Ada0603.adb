with Text_IO, Ada.Long_Float_Text_IO, Ada.Integer_Text_IO, Ada.Numerics;
use  Text_IO, Ada.Long_Float_Text_IO, Ada.Integer_Text_IO, Ada.Numerics;

procedure Ada0603 is
    a : Constant Long_Float := 0.0;
    b : Constant Long_Float := 1.0;

    h, s, x : Long_Float;
    s2, s4  : Long_Float;
    n       : Integer;

    function f(x:Long_Float) return Long_Float is
    begin
        return 4.0 / (1.0 + x * x);
    end f;

begin
    -- Simpson‘¥‚ÅÏ•ª
    n := 2;
    for j in 1..5 loop
        h  := (b - a) / Long_Float(n);
        s2 := 0.0;
        s4 := 0.0;
        x  := a + h;
        for i in 1..(n / 2) loop
            s4 := s4 + f(x);
            x  := x  + h;
            s2 := s2 + f(x);
            x  := x  + h;
        end loop;
        s2 := (s2 - f(b)) * 2.0 + f(a) + f(b);
        s4 := s4 * 4.0;
        s  := (s2 + s4) * h / 3.0;
        n  := n * 2;

        -- Œ‹‰Ê‚ð ƒÎ ‚Æ”äŠr
        Put(j,                   Width=> 2);
        Put(" : ");
        Put(s ,                  Fore=>3, Aft=>10, Exp=>0);
        Put(", ");
        Put(s - Ada.Numerics.Pi, Fore=>3, Aft=>10, Exp=>0);
        New_Line;
    end loop;
end Ada0603;
