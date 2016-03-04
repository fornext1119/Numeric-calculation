with TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada1102 is

    N : Constant Integer := 3;

    type Long_Float_Array       is array (0..N)       of Long_Float;
    type Long_Float_TwoDimArray is array (0..N, 0..N) of Long_Float;

    a:Long_Float_TwoDimArray := ((5.0, 4.0, 1.0, 1.0)
                                ,(4.0, 5.0, 1.0, 1.0)
                                ,(1.0, 1.0, 4.0, 2.0)
                                ,(1.0, 1.0, 2.0, 4.0));

    x:Long_Float_Array := (1.0, 0.0, 0.0, 0.0);
        
    -- １次元配列を表示
    procedure disp_vector(row:Long_Float_Array) is
    begin
        for i in row'Range loop
            Put(row(i), Fore=>3, Aft=>10, Exp=>0);
            Put(Ascii.HT);
        end loop;
        New_Line;
    end disp_vector;

    -- 正規化 (ベクトルの長さを１にする)
    procedure normarize(x:in out Long_Float_Array) is
        s:Long_Float;
    begin
        s := 0.0;
        for i in x'Range loop
            s := s + x(i) * x(i);        
        end loop;
        s := Sqrt(s);
            
        for i in x'Range loop
            x(i) := x(i) / s;        
        end loop;
        end normarize;

    -- LU分解
    procedure forward_elimination(a:in out Long_Float_TwoDimArray) is
        s:Long_Float;
    begin
        for pivot in a'First..(a'Last - 1) loop
            for row in (pivot + 1)..a'Last loop
                s := a(row,pivot) / a(pivot,pivot);
                for col in pivot..a'Last loop
                    a(row,col) := a(row,col) - a(pivot,col) * s; -- これが 上三角行列
                end loop;
                a(row,pivot)   := s;                             -- これが 下三角行列
            end loop;
        end loop;
    end forward_elimination;

    -- 前進代入 (Ly = b から y を求める)
    procedure forward_substitution(a:Long_Float_TwoDimArray; y:in out Long_Float_Array; b:in out Long_Float_Array) is
    begin
        for row in a'Range loop
            for col in a'First..row loop
                b(row) := b(row) - a(row,col) * y(col);
            end loop;
            y(row) := b(row);
        end loop;
    end forward_substitution;

    -- 後退代入 (Ux = y から x を求める)
    procedure backward_substitution(a:Long_Float_TwoDimArray; x:in out Long_Float_Array; y:in out Long_Float_Array) is
    begin
        for row in reverse a'Range loop
            for col in reverse (row + 1)..a'Last loop
                y(row) := y(row) - a(row,col) * x(col);
            end loop;
            x(row) := y(row) / a(row,row);
        end loop;
    end backward_substitution;
    
    -- 逆ベキ乗法
    procedure inverse(a:Long_Float_TwoDimArray; x0:in out Long_Float_Array; lambda:out Long_Float) is
        p0, p1, e0, e1:Long_Float;
        b:Long_Float_Array  := (0.0, 0.0, 0.0, 0.0);
        y:Long_Float_Array  := (0.0, 0.0, 0.0, 0.0);
        x1:Long_Float_Array := (0.0, 0.0, 0.0, 0.0);
    begin
        -- 正規化 (ベクトル x0 の長さを１にする)
        normarize(x0);
        e0 := 0.0;
        for i in x0'Range loop
            e0 := e0 + x0(i);
        end loop;
        
        for k in 1..100 loop
            -- １次元配列を表示
            Put(k, Width=> 3);
            Put(Ascii.HT);
            disp_vector(x0);

            -- Ly = b から y を求める (前進代入)
            for i in x0'Range loop
                b(i) := x0(i);
                y(i) := 0.0;
            end loop;
            forward_substitution(a,y,b);

            -- Ux = y から x を求める (後退代入)
            for i in x1'Range loop
                x1(i) := 0.0;
            end loop;
            backward_substitution(a,x1,y);

            -- 内積
            p0 := 0.0;
            p1 := 0.0;
            for i in x0'Range loop
                p0 := p0 + x1(i) * x1(i);
                p1 := p1 + x1(i) * x0(i);
            end loop;
            -- 固有値
            lambda := p1 / p0;

            -- 正規化 (ベクトル x1 の長さを１にする)
            normarize(x1);
            -- 収束判定
            e1 := 0.0;
            for i in x0'Range loop
                e1 := e1 + x1(i);
            end loop;
            if Abs(e1 - e0) < 0.00000000001 then
                exit;
            end if;
            
            for i in x0'Range loop
                x0(i) := x1(i);
            end loop;
            e0 := e1;
        end loop;
    end inverse;

-- 逆ベキ乗法で最小固有値を求める
    lambda:Long_Float := 0.0;
begin
    -- LU分解
    forward_elimination(a);
    
    -- 逆ベキ乗法
    inverse(a, x, lambda);
    
    Put_Line("");
    Put_Line("eigenvalue");    
    Put(lambda, Fore=>3, Aft=>10, Exp=>0);
    New_Line;

    Put_Line("eigenvector");
    disp_vector(x);
end Ada1102;
