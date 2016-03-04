with Text_IO, Ada.Long_Float_Text_IO;
use  Text_IO, Ada.Long_Float_Text_IO;

procedure Ada0704 is
    -- データ点の数 - 1
    N :   Constant Integer :=  6;
    Nx2 : Constant Integer := 13;

    type Long_Float_ArrayN   is array (0..N)   of Long_Float;
    type Long_Float_ArrayNx2 is array (0..Nx2) of Long_Float;
    x  : Long_Float_ArrayN;
    y  : Long_Float_ArrayN;
    yd : Long_Float_ArrayN;
    z  : Long_Float_ArrayNx2;
    a  : Long_Float_ArrayNx2;
    d : array (0..Nx2, 0..Nx2) of Long_Float;
    d1, d2, d3 : Long_Float;
    k : Integer;

    -- 元の関数
    function f(x:Long_Float) return Long_Float is
    begin
        return x - Long_Float(x ** 3) / Long_Float(3 * 2) + Long_Float(x ** 5) / Long_Float(5 * 4 * 3 * 2);
    end f;
    
    -- 導関数
    function fd(x:Long_Float) return Long_Float is
    begin
        return 1.0 - Long_Float(x ** 2) / Long_Float(2) + Long_Float(x ** 4) / Long_Float(4 * 3 * 2);
    end fd;
    
    -- Hermite (エルミート) 補間
    function hermite(d:Long_Float; z:Long_Float_ArrayNx2; a:Long_Float_ArrayNx2) return Long_Float is
        sum, prod :Long_Float;
    begin
        sum := a(0);
        for i in 1 .. a'Last loop
            prod := a(i);
            for j in z'First .. i-1 loop
                prod := prod * (d - z(j));
            end loop;
            sum := sum + prod;
        end loop;
        return sum;
    end;
begin
    -- 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for i in x'Range loop
        d1    := Long_Float(i) * 1.5 - 4.5;
        x(i)  := d1;
        y(i)  := f(d1);
        yd(i) := fd(d1);
    end loop;
    
    -- 差分商の表を作る
    for i in z'Range loop
        k      := i / 2;
        z(i)   := x(k);
        d(0,i) := y(k);
    end loop;

    for i in 1 .. z'Last loop
        for j in z'First .. z'Last-i loop
            if (i = 1) and (j mod 2 = 0) then
                d(i,j) := yd(j / 2);
            else
                d(i,j) := (d(i-1,j+1) - d(i-1,j)) / (z(j+i) - z(j));
            end if;
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
        d3 := hermite(d1, z, a);

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
end Ada0704;
