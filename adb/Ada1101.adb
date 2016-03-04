with TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada1101 is

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


    -- ベキ乗法
    procedure power(a:Long_Float_TwoDimArray; x0:in out Long_Float_Array; lambda:out Long_Float) is
        p0, p1, e0, e1:Long_Float;
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

            -- 行列の積 x1 = A × x0 
            for i in x1'Range loop
                x1(i) := 0.0;
            end loop;
            for i in x1'Range loop
                for j in x1'Range loop
                    x1(i) := x1(i) + a(i, j) * x0(j);
                end loop;
            end loop;

            -- 内積
            p0 := 0.0;
            p1 := 0.0;
            for i in x0'Range loop
                p0 := p0 + x1(i) * x1(i);
                p1 := p1 + x1(i) * x0(i);
            end loop;
            -- 固有値
            lambda := p0 / p1;

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
    end power;

-- ベキ乗法で最大固有値を求める
    lambda:Long_Float := 0.0;
begin
    -- ベキ乗法
    power(a, x, lambda);

    Put_Line("");
    Put_Line("eigenvalue");    
    Put(lambda, Fore=>3, Aft=>10, Exp=>0);
    New_Line;

    Put_Line("eigenvector");
    disp_vector(x);
end Ada1101;
