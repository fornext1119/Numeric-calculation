with Text_IO, Ada.Long_Float_Text_IO;
use  Text_IO, Ada.Long_Float_Text_IO;

procedure Ada0703 is
    -- データ点の数 - 1
    N : Constant Integer := 6;

    type Long_Float_Array is array (0..N) of Long_Float;
    x : Long_Float_Array;
    y : Long_Float_Array;
    a : Long_Float_Array;
    d : array (0..N, 0..N) of Long_Float;
    d1, d2, d3 : Long_Float;

    -- 元の関数
    function f(x:Long_Float) return Long_Float is
    begin
        return x - Long_Float(x ** 3) / Long_Float(3 * 2) + Long_Float(x ** 5) / Long_Float(5 * 4 * 3 * 2);
    end f;
    
    -- Newton (ニュートン) 補間
    function newton(d:Long_Float; x:Long_Float_Array; a:Long_Float_Array) return Long_Float is
        sum, prod :Long_Float;
    begin
        sum := a(0);
        for i in 1 .. x'Last loop
            prod := a(i);
            for j in x'First .. i-1 loop
                prod := prod * (d - x(j));
            end loop;
            sum := sum + prod;
        end loop;
        return sum;
    end;
begin
    -- 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for i in x'Range loop
        d1   := Long_Float(i) * 1.5 - 4.5;
        x(i) := d1;
        y(i) := f(d1);
    end loop;
    
    -- 差分商の表を作る
    for j in y'Range loop
        d(0,j) := y(j);
    end loop;

    for i in 1 .. x'Last loop
        for j in x'First .. x'Last-i loop
            d(i,j) := (d(i-1,j+1) - d(i-1,j)) / (x(j+i) - x(j));
        end loop;
    end loop;

    -- ｎ階差分商
    for j in a'Range loop
        a(j) := d(j,0);
    end loop;

    -- 0.5刻みで 与えられていない値を補間 
    for i in 0..18 loop
        d1  := Long_Float(i) * 0.5 - 4.5;
        d2 := f(d1);
        d3 := newton(d1, x, a);

        -- 元の関数と比較
        Put(d1,      Fore=>2, Aft=>2, Exp=>0);
        Put(Ascii.HT);
        Put(d2,      Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(d3,      Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(d2 - d3, Fore=>3, Aft=>5, Exp=>0);
        New_Line;
    end loop;
end Ada0703;
