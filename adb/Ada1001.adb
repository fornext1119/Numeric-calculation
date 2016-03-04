with TEXT_IO, Ada.Long_Float_Text_IO;
use  TEXT_IO, Ada.Long_Float_Text_IO;

procedure Ada1001 is

    N:Constant Integer := 3;

    type Long_Float_Array       is array (0..N)       of Long_Float;
    type Long_Float_TwoDimArray is array (0..N, 0..N) of Long_Float;

    a:Long_Float_TwoDimArray := (( 9.0,  2.0, 1.0,  1.0), (2.0, 8.0, -2.0, 1.0), (-1.0, -2.0, 7.0, -2.0), (1.0, -1.0, -2.0, 6.0));
    b:Long_Float_Array := (20.0, 16.0, 8.0, 17.0);
    c:Long_Float_Array := ( 0.0,  0.0, 0.0,  0.0);

    -- １次元配列を表示
    procedure disp_vector(row:Long_Float_Array) is
    begin
        for i in row'Range loop
            Put(row(i), Fore=>3, Aft=>10, Exp=>0);
            Put(Ascii.HT);
        end loop;
        New_Line;
    end disp_vector;

    -- ヤコビの反復法
    procedure jacobi(a:Long_Float_TwoDimArray; b:Long_Float_Array; x0:in out Long_Float_Array) is
        x1:Long_Float_Array := ( 0.0,  0.0, 0.0,  0.0);
        finish:Boolean;
    begin
        while true loop
            finish := true;
            for i in x0'Range loop
                x1(i) := 0.0;
                for j in x0'Range loop
                    if j /= i then
                        x1(i) := x1(i) + a(i,j) * x0(j);
                    end if;
                end loop;

                x1(i) := (b(i) - x1(i)) / a(i,i);
                if (abs(x1(i) - x0(i)) > 0.0000000001) then 
                    finish := false;
                end if;
            end loop;
            for i in x0'Range loop
                x0(i) := x1(i);
            end loop;
            if finish then
                exit;
            end if;

            disp_vector(x0);
        end loop;
    end jacobi;
begin
    -- ヤコビの反復法
    jacobi(a,b,c);

    Put_Line("X");
    disp_vector(c);
end Ada1001;
