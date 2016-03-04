program Pas1002(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    N = 3;

type
    TwoDimArray = array [0..N,0..N] of Double;

// １次元配列を表示
procedure disp_vector(row:array of Double); 
var
    i:Integer;
begin
    for i := Low(row) to High(row) do
        write(format('%14.10f'#9, [row[i]]));
    writeln();
end;        

// ガウス・ザイデル法
procedure gauss(a:TwoDimArray; b:array of Double; var x0:array of Double); 
var
    x1 :Double;
    finish:Boolean;
    i, j:Integer;
begin
    while (true) do
    begin
        finish := true;
        for i := Low(x0) to High(x0) do
        begin
            x1 := 0.0;
            for j := Low(x0) to High(x0) do
                if j <> i then
                    x1 := x1 + a[i,j] * x0[j];

            x1 := (b[i] - x1) / a[i,i];
            if (abs(x1 - x0[i]) > 0.0000000001) then finish := false;
            x0[i] := x1;
        end;
        if finish then exit;

        disp_vector(x0);
    end;

end;

var
    a :TwoDimArray = (( 9.0,  2.0, 1.0,  1.0), (2.0, 8.0, -2.0, 1.0), (-1.0, -2.0, 7.0, -2.0), (1.0, -1.0, -2.0, 6.0));
    b :array [0..N] of Double = (20.0, 16.0, 8.0, 17.0);
    c :array [0..N] of Double = ( 0.0,  0.0, 0.0,  0.0);
begin
    // ガウス・ザイデル法
    gauss(a,b,c);

    writeln('X');
    disp_vector(c);
end.
