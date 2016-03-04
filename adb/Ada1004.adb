with TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;
use  TEXT_IO, Ada.Long_Float_Text_IO, Ada.Numerics.Long_Elementary_Functions;

procedure Ada1004 is

    N : Constant Integer := 3;

    type Long_Float_Array       is array (0..N)       of Long_Float;
    type Long_Float_TwoDimArray is array (0..N, 0..N) of Long_Float;

    a:Long_Float_TwoDimArray := ((-1.0, -2.0, 7.0, -2.0), (1.0, -1.0, -2.0, 6.0), ( 9.0,  2.0, 1.0,  1.0), (2.0, 8.0, -2.0, 1.0));
    b:Long_Float_Array := (8.0, 17.0, 20.0, 16.0);

    -- �P�����z���\��
    procedure disp_vector(row:Long_Float_Array) is
    begin
        for i in row'Range loop
            Put(row(i), Fore=>3, Aft=>10, Exp=>0);
            Put(Ascii.HT);
        end loop;
        New_Line;
    end disp_vector;

    -- �Q�����z���\��
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

    -- �O�i����
    procedure forward_elimination(a:in out Long_Float_TwoDimArray; b:in out Long_Float_Array) is 
        s:Long_Float;
    begin
        for pivot in a'Range loop
            for row in a'Range loop
                if row /= pivot then
                    s := a(row,pivot) / a(pivot,pivot);
	                for col in pivot..a'Last loop
	                    a(row,col) := a(row,col) - a(pivot,col) * s;
	    			end loop;
	                b(row)         := b(row)     - b(pivot)     * s;
				end if;
            end loop;
        end loop;
    end forward_elimination;

	-- ��ޑ��
	procedure backward_substitution(a:Long_Float_TwoDimArray; b:in out Long_Float_Array) is
	begin
        for pivot in a'Range loop
	        b(pivot) := b(pivot) / a(pivot,pivot);
	    end loop;
	end backward_substitution;

	-- �s�{�b�g�I��
	procedure pivoting(a:in out Long_Float_TwoDimArray; b:in out Long_Float_Array) is
	    max_val, tmp:Long_Float;
	    max_row:Integer;
	begin
	    for pivot in a'Range loop
	        -- �e��� ��Ԓl���傫���s�� �T��
	        max_row :=   pivot;
	        max_val :=   0.0;
	        for row in  pivot..a'Last loop
	            if abs(a(row,pivot)) > max_val then
	                -- ��Ԓl���傫���s
	                max_val :=   abs(a(row,pivot));
	                max_row :=   row;
	            end if;
	        end loop;

	        -- ��Ԓl���傫���s�Ɠ���ւ�
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
    -- �s�{�b�g�I��
    pivoting(a,b);

    Put_Line("pivoting");
    Put_Line("A");
    disp_matrix(a);
    Put_Line("B");
    disp_vector(b);
    Put_Line("");

    -- �O�i����
    forward_elimination(a,b);

    Put_Line("forward elimination");
    Put_Line("A");
    disp_matrix(a);
    Put_Line("B");
    disp_vector(b);
    Put_Line("");

    -- ��ޑ��
    backward_substitution(a,b);

    Put_Line("X");
    disp_vector(b);
end Ada1004;