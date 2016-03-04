with Text_IO, Ada.Long_Float_Text_IO;
use  Text_IO, Ada.Long_Float_Text_IO;

procedure Ada0702 is
    -- �f�[�^�_�̐� - 1
    N : Constant Integer := 6;

    type Long_Float_Array is array (0..N) of Long_Float;
    x : Long_Float_Array;
    y : Long_Float_Array;
    d, d1, d2 : Long_Float;

    -- ���̊֐�
    function f(x:Long_Float) return Long_Float is
    begin
        return x - Long_Float(x ** 3) / Long_Float(3 * 2) + Long_Float(x ** 5) / Long_Float(5 * 4 * 3 * 2);
    end f;
    
    -- Neville (�l���B��) ���
    function neville(d:Long_Float; x:Long_Float_Array; y:Long_Float_Array) return Long_Float is
        w : array (0..N, 0..N) of Long_Float;
    begin
        for i in y'Range loop
            w(0, i) := y(i);
        end loop;

        for j in 1 .. x'Last loop
            for i in x'First .. x'Last-j loop
                w(j,i) := w(j-1,i+1) + (w(j-1,i+1) - w(j-1,i)) * (d - x(i+j)) / (x(i+j) - x(i));
            end loop;
        end loop;
        return w(N,0);
    end;
begin
    -- 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for i in x'Range loop
        d    := Long_Float(i) * 1.5 - 4.5;
        x(i) := d;
        y(i) := f(d);
    end loop;
    
    -- 0.5���݂� �^�����Ă��Ȃ��l���� 
    for i in 0..18 loop
        d  := Long_Float(i) * 0.5 - 4.5;
        d1 := f(d);
        d2 := neville(d, x, y);

        -- ���̊֐��Ɣ�r
        Put(d,       Fore=>2, Aft=>2, Exp=>0);
        Put(Ascii.HT);
        Put(d1,      Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(d2,      Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(d1 - d2, Fore=>3, Aft=>5, Exp=>0);
        New_Line;
    end loop;
end Ada0702;
