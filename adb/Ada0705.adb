with Text_IO, Ada.Long_Float_Text_IO;
use  Text_IO, Ada.Long_Float_Text_IO;

procedure Ada0705 is
    -- �f�[�^�_�̐� - 1
    N : Constant Integer := 6;

    type Long_Float_Array is array (0..N) of Long_Float;
    x : Long_Float_Array;
    y : Long_Float_Array;
    a : Long_Float_Array;
    b : Long_Float_Array;
    c : Long_Float_Array;
    d : Long_Float_Array;
    g : Long_Float_Array;
    s : Long_Float_Array;
    z : Long_Float_Array;
    d1, d2, d3 : Long_Float;
    k : Integer;

    -- ���̊֐�
    function f(x:Long_Float) return Long_Float is
    begin
        return x - Long_Float(x ** 3) / Long_Float(3 * 2) + Long_Float(x ** 5) / Long_Float(5 * 4 * 3 * 2);
    end f;
    
    -- Spline (�X�v���C��) ���
    function spline(d:Long_Float; x:Long_Float_Array; y:Long_Float_Array; z:Long_Float_Array) return Long_Float is
        d1, d2, d3 : Long_Float;
        k : Integer;
    begin
	    -- ��Ԋ֐��l���ǂ̋�Ԃɂ��邩
	    k := -1;
        for i in 1 .. x'Last loop
	        if d <= x(i) then
	            k := i - 1;
	            exit;
	        end if;
	    end loop;
	    if k < 0 then
			k := N;
		end if;

	    d1   := x(k+1) - d;
	    d2   := d      - x(k);
	    d3   := x(k+1) - x(k);
	    return (z(k) * (d1 ** 3) + z(k+1) * (d2 ** 3)) / (6.0 * d3)
	            + (y(k)   / d3 - z(k)   * d3 / 6.0) * d1  
	            + (y(k+1) / d3 - z(k+1) * d3 / 6.0) * d2;
    end;
begin
    -- 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for i in x'Range loop
        d1    := Long_Float(i) * 1.5 - 4.5;
        x(i)  := d1;
        y(i)  := f(d1);
    end loop;
    
    -- �R���������̌W���̕\�����
    for i in 1..x'Last-1 loop
        a(i) :=         x(i)   - x(i-1); 
        b(i) := 2.0 *  (x(i+1) - x(i-1)); 
        c(i) :=         x(i+1) - x(i); 
        d(i) := 6.0 * ((y(i+1) - y(i)) / (x(i+1) - x(i)) - (y(i) - y(i-1)) / (x(i) - x(i-1)));
    end loop;
    -- �R�������������� (�g�|�}�X�@)
    g(1) := b(1);
    s(1) := d(1);
    for i in 2..a'Last-1 loop
        g(i) := b(i) - a(i) * c(i-1) / g(i-1);
        s(i) := d(i) - a(i) * s(i-1) / g(i-1);
    end loop;
    z(0)   := 0.0;
    z(N)   := 0.0;
    z(N-1) := s(N-1) / g(N-1);
	k := N - 2;
	while k > 0 loop
        z(k) := (s(k) - c(k) * z(k+1)) / g(k);
	    k := k - 1;
	end loop;

    -- 0.5���݂� �^�����Ă��Ȃ��l���� 
    for i in 0..18 loop
        d1  := Long_Float(i) * 0.5 - 4.5;
        d2 := f(d1);
        d3 := spline(d1, x, y, z);

        -- ���̊֐��Ɣ�r
        Put(d1,      Fore=>2, Aft=>2, Exp=>0);
        Put(Ascii.HT);
        Put(d2,      Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(d3,      Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(d2 - d3, Fore=>3, Aft=>5, Exp=>0);
        New_Line;
    end loop;
end Ada0705;
