program Pas1001(arg);
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

// ヤコビの反復法
procedure jacobi(a:TwoDimArray; b:array of Double; var x0:array of Double); 
var
    x1:array [0..N] of Double = (0.0, 0.0, 0.0, 0.0);
    finish:Boolean;
    i, j:Integer;
begin
    while (true) do
    begin
        finish := true;
        for i := Low(x0) to High(x0) do
        begin
            x1[i] := 0.0;
            for j := Low(x0) to High(x0) do
                if j <> i then
                    x1[i] := x1[i] + a[i,j] * x0[j];

            x1[i] := (b[i] - x1[i]) / a[i,i];
            if (abs(x1[i] - x0[i]) > 0.0000000001) then finish := false;
        end;
        for i := Low(x0) to High(x0) do
            x0[i] := x1[i];
        if finish then exit;

        disp_vector(x0);
    end;
end;

var
    a:TwoDimArray = (( 9.0,  2.0, 1.0,  1.0), (2.0, 8.0, -2.0, 1.0), (-1.0, -2.0, 7.0, -2.0), (1.0, -1.0, -2.0, 6.0));
    b:array [0..N] of Double = (20.0, 16.0, 8.0, 17.0);
    c:array [0..N] of Double = ( 0.0,  0.0, 0.0,  0.0);
begin
    // ヤコビの反復法
    jacobi(a,b,c);

    writeln('X');
    disp_vector(c);
end.
