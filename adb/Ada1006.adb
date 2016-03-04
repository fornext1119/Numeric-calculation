with TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada1006 is

    N : Constant Integer := 3;

    type Long_Float_Array       is array (0..N)       of Long_Float;
    type Long_Float_TwoDimArray is array (0..N, 0..N) of Long_Float;

    a:Long_Float_TwoDimArray := ((5.0,2.0,3.0,4.0),(2.0,10.0,6.0,7.0),(3.0,6.0,15.0,9.0),(4.0,7.0,9.0,20.0));
    b:Long_Float_Array := (34.0,68.0,96.0,125.0);
    y:Long_Float_Array := (0.0, 0.0, 0.0, 0.0);
    x:Long_Float_Array := (0.0, 0.0, 0.0, 0.0);

    -- １次元配列を表示
    procedure disp_vector(row:Long_Float_Array) is
    begin
        for i in row'Range loop
            Put(row(i), Fore=>3, Aft=>10, Exp=>0);
            Put(Ascii.HT);
        end loop;
        New_Line;
    end disp_vector;

    -- ２次元配列を表示
    procedure disp_matrix(matrix:Long_Float_TwoDimArray) is
    begin
        for i in matrix'Range loop
            for j in matrix'Range loop
                Put(matrix(i,j), Fore=>3, Aft=>10, Exp=>0);
                Put(Ascii.HT);
            end loop;
            New_Line;
        end loop;
    end disp_matrix;

    -- 前進消去
    procedure forward_elimination(a:in out Long_Float_TwoDimArray; b:in out Long_Float_Array) is 
        s:Long_Float;
    begin
        for pivot in a'Range loop
            s := 0.0;
            for col in a'First..(pivot - 1) loop
            	s := s + a(pivot,col) * a(pivot,col);
			end loop;
	        -- ここで根号の中が負の値になると計算できない！
	        a(pivot,pivot) := sqrt(a(pivot,pivot) - s);

            for row in (pivot + 1)..a'Last loop
	            s := 0.0;
                for col in a'First..(pivot - 1) loop
	                s := s + a(row,col) * a(pivot,col);
				end loop;
	            a(row,pivot) := (a(row,pivot) - s) / a(pivot,pivot);
	            a(pivot,row) := a(row,pivot);
            end loop;
        end loop;
    end forward_elimination;

	-- 前進代入
	procedure forward_substitution(a:Long_Float_TwoDimArray; b:in out Long_Float_Array; y:in out Long_Float_Array) is 
	begin
	    for row in a'Range loop
	        for col in a'First..row loop
	            b(row) := b(row) - a(row,col) * y(col);
			end loop;
	        y(row) := b(row) / a(row,row);
	    end loop;
	end forward_substitution;

	-- 後退代入
	procedure backward_substitution(a:Long_Float_TwoDimArray; y:in out Long_Float_Array; x:in out Long_Float_Array) is
	begin
	    for row in reverse a'Range loop
	        for col in reverse (row + 1)..a'Last loop
	            y(row) := y(row) - a(row,col) * x(col);
			end loop;
	        x(row) := y(row) / a(row,row);
	    end loop;
	end backward_substitution;

begin
    Put_Line("A");
    disp_matrix(a);
    Put_Line("B");
    disp_vector(b);
    Put_Line("");

    -- 前進消去
    forward_elimination(a,b);

    Put_Line("LL^T");
    disp_matrix(a);

    -- Ly=b から y を求める (前進代入)
    forward_substitution(a,b,y);

    Put_Line("Y");
    disp_vector(y);

    -- L^Tx=y から x を求める (後退代入)
    backward_substitution(a,y,x);

    Put_Line("X");
    disp_vector(x);
end Ada1006;
