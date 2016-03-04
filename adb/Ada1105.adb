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

    v:Long_Float_TwoDimArray := ((1.0 ,0.0 ,0.0 ,0.0)
                                ,(0.0 ,1.0 ,0.0 ,0.0)
                                ,(0.0 ,0.0 ,1.0 ,0.0)
                                ,(0.0 ,0.0 ,0.0 ,1.0));

    -- �P�����z���\��
    procedure disp_vector(row:Long_Float_Array) is
    begin
        for i in row'Range loop
            Put(row(i), Fore=>3, Aft=>10, Exp=>0);
            Put(Ascii.HT);
        end loop;
        New_Line;
    end disp_vector;

    -- ���K�� (�x�N�g���̒������P�ɂ���)
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

    -- �Ίp�v�f��\��
	procedure disp_eigenvalue(a:Long_Float_TwoDimArray) is
	    for i in 0..N loop
            Put(a(i, i), Fore=>3, Aft=>10, Exp=>0);
            Put(Ascii.HT);
        end loop;
        New_Line;
    end disp_eigenvalue;

    -- �ŗL�x�N�g����\��
	procedure disp_eigenvector(matrix:Long_Float_TwoDimArray) is
	    row:Long_Float_Array;
	begin
	    for i in 0..N loop
            for j in 0..N loop
				row(j) := matrix(i, j);
		    end loop;
	        normarize(row);
	        disp_vector(row);
	    end loop;
	end disp_eigenvector;

	-- ���R�r�@
    procedure jacobi(a:in out Long_Float_TwoDimArray; v:in out Long_Float_TwoDimArray) is
        p, q:Integer;
	    max_val:Long_Float;
    begin
        for k in 1..100 loop
	        -- �ő�l��T��
	        max_val := 0.0;
            for i in 0..N loop
                for j in (i + 1)..N loop
	                if (max_val < Abs(a(i, j))) then
	                    max_val := Abs(a(i, j));
	                    p := i;
	                    q := j;
	                end if;
	            end loop;
	        end loop;

	        -- �� �����߂�
	        Dim t As Double = 0.0
	        If Math.Abs(a(p, p) - a(q, q)) < 0.00000000001 Then
	            'a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
	            t = Math.PI / 4.0
	            If (a(p, p) < 0) Then
	                t = -t
				End if
	        Else
	            'a_{pp} �� a_{qq} �̂Ƃ�
	            t = Math.Atan(2.0 * a(p, q) / (a(p, p) - a(q, q))) / 2.0
	        End If

	        '�� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
	        Dim c As Double = Math.Cos(t)
	        Dim s As Double = Math.Sin(t)
	        'U^t �~ A
	        Dim t1 As Double = 0.0
	        Dim t2 As Double = 0.0
	        For i As Integer = 0 To N
	            t1      =  a(p, i) * c + a(q, i) * s
	            t2      = -a(p, i) * s + a(q, i) * c
	            a(p, i) = t1
	            a(q, i) = t2
	            '�ŗL�x�N�g��
	            t1      =  v(p, i) * c + v(q, i) * s
	            t2      = -v(p, i) * s + v(q, i) * c
	            v(p, i) = t1
	            v(q, i) = t2
	        Next
	        'A �~ U
	        For i As Integer = 0 To N
	            t1      =  a(i, p) * c + a(i, q) * s
	            t2      = -a(i, p) * s + a(i, q) * c
	            a(i, p) = t1
	            a(i, q) = t2
	        Next

	        '�Ίp�v�f��\��
	        Console.Write(string.Format("{0,3:D}{1}", k, vbTab))
	        disp_eigenvalue(a)

	        '��������
        	If max_val < 0.00000000001 Then Exit For
	    Next
	End Sub

-- ���R�r�@�ŌŗL�l�����߂�
begin
	-- ���R�r�@
	jacobi(a, v);

    Put_Line("");
    Put_Line("eigenvalue");    
	disp_eigenvalue(a);
    New_Line;

    Put_Line("eigenvector");
	disp_eigenvector(v);
end Ada1105;
