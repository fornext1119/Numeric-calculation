with Text_IO, Ada.Long_Float_Text_IO;
use  Text_IO, Ada.Long_Float_Text_IO;

procedure Ada0701 is
    -- データ点の数 - 1
    N : Constant Integer := 6;

    type Long_Float_Array is array (0..N) of Long_Float;
    x : Long_Float_Array;
    y : Long_Float_Array;
    d, d1, d2 : Long_Float;

    -- 元の関数
    function f(x:Long_Float) return Long_Float is
    begin
        return x - Long_Float(x ** 3) / Long_Float(3 * 2) + Long_Float(x ** 5) / Long_Float(5 * 4 * 3 * 2);
    end f;
    
    -- Lagrange (ラグランジュ) 補間
    function lagrange(d:Long_Float; x:Long_Float_Array; y:Long_Float_Array) return Long_Float is
        sum, prod :Long_Float;
    begin
        sum := Long_Float(0.0);
        for i in x'Range loop
            prod := y(i);
            for j in x'Range loop
                if j /= i then
                    prod := prod * (d - x(j)) / (x(i) - x(j));
                end if;
            end loop;
            sum := sum + prod;
        end loop;
        return sum;
    end;
begin
    -- 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for i in x'Range loop
        d    := Long_Float(i) * 1.5 - 4.5;
        x(i) := d;
        y(i) := f(d);
    end loop;
    
    -- 0.5刻みで 与えられていない値を補間 
    for i in 0..18 loop
        d  := Long_Float(i) * 0.5 - 4.5;
        d1 := f(d);
        d2 := lagrange(d, x, y);

        -- 元の関数と比較
        Put(d,       Fore=>2, Aft=>2, Exp=>0);
        Put(Ascii.HT);
        Put(d1,      Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(d2,      Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(d1 - d2, Fore=>3, Aft=>5, Exp=>0);
        New_Line;
    end loop;
end Ada0701;
