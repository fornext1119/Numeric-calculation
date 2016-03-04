with TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada1005 is

    N : Constant Integer := 3;

    type Long_Float_Array       is array (0..N)       of Long_Float;
    type Long_Float_TwoDimArray is array (0..N, 0..N) of Long_Float;

    a:Long_Float_TwoDimArray := ((-1.0, -2.0, 7.0, -2.0), (1.0, -1.0, -2.0, 6.0), ( 9.0,  2.0, 1.0,  1.0), (2.0, 8.0, -2.0, 1.0));
    b:Long_Float_Array := (8.0, 17.0, 20.0, 16.0);
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
        for pivot in a'First..(a'Last - 1) loop
            for row in (pivot + 1)..a'Last loop
                s := a(row,pivot) / a(pivot,pivot);
                for col in pivot..a'Last loop
                    a(row,col) := a(row,col) - a(pivot,col) * s; -- これが 上三角行列
        		end loop;
	            a(row,pivot)   := s;                             -- これが 下三角行列
                -- b(row)      := b(row)     - b(pivot)     * s; -- この値は変更しない
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
	        y(row) := b(row);
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

	-- ピボット選択
	procedure pivoting(a:in out Long_Float_TwoDimArray; b:in out Long_Float_Array) is
	    max_val, tmp:Long_Float;
	    max_row:Integer;
	begin
	    for pivot in a'Range loop
	        -- 各列で 一番値が大きい行を 探す
	        max_row :=   pivot;
	        max_val :=   0.0;
	        for row in  pivot..a'Last loop
	            if abs(a(row,pivot)) > max_val then
	                -- 一番値が大きい行
	                max_val :=   abs(a(row,pivot));
	                max_row :=   row;
	            end if;
	        end loop;

	        -- 一番値が大きい行と入れ替え
	        if max_row /= pivot then
	            tmp := 0.0;
	            for col in a'Range loop
	                tmp            :=   a(max_row,col);
	                a(max_row,col) :=   a(pivot,col);
	                a(pivot,col)   :=   tmp;
	            end loop;
	            tmp        :=   b(max_row);
	            b(max_row) :=   b(pivot);
	            b(pivot)   :=   tmp;
	        end if;
	    end loop;
	end pivoting;

begin
    -- ピボット選択
    pivoting(a,b);

    Put_Line("pivoting");
    Put_Line("A");
    disp_matrix(a);
    Put_Line("B");
    disp_vector(b);
    Put_Line("");

    -- 前進消去
    forward_elimination(a,b);

    Put_Line("LU");
    disp_matrix(a);

    -- Ly=b から y を求める (前進代入)
    forward_substitution(a,b,y);

    Put_Line("Y");
    disp_vector(y);

    -- Ux=y から x を求める (後退代入)
    backward_substitution(a,y,x);

    Put_Line("X");
    disp_vector(x);
end Ada1005;
