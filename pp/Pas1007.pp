program Pas1007(arg);
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
// ２次元配列を表示
procedure disp_matrix(matrix:TwoDimArray); 
var
    i,j:Integer;
begin
    for i := Low(matrix) to High(matrix) do
    begin
        for j := Low(matrix) to High(matrix) do
            write(format('%14.10f'#9, [matrix[i,j]]));
        writeln();
    end;
end;        
// 前進消去
procedure forward_elimination(var a:TwoDimArray; var b:array of Double); 
var
    s:Double;
    pivot, row, col, k:Integer;
begin
    for pivot := Low(a) to High(a) do
    begin
        // pivot < k の場合
        s := 0;
        for col := Low(a) to pivot - 1 do
        begin
            s := a[pivot,col];
            for k := Low(a) to col - 1 do
                s := s - a[pivot,k] * a[col,k] * a[k,k];
            a[pivot,col] := s / a[col,col];
            a[col,pivot] := a[pivot,col];
        end;

        // pivot == k の場合
        s := a[pivot,pivot];
        for k := Low(a) to pivot - 1 do
            s := s - a[pivot,k] * a[pivot,k] * a[k,k];
        a[pivot,pivot] := s;
    end;
end;
// 前進代入
procedure forward_substitution(a:TwoDimArray; b:array of Double; var y:array of Double); 
var
    row, col:Integer;
begin
    for row := Low(a) to High(a) do
    begin
        for col := Low(a) to row do
            b[row] := b[row] - a[row,col] * y[col];
        y[row] := b[row];
    end;
end;
// 後退代入
procedure backward_substitution(a:TwoDimArray; y:array of Double; var x:array of Double); 
var
    row, col:Integer;
begin
    for row := High(a) downto Low(a) do
    begin
        for col := High(a) downto row + 1 do
            y[row] := y[row] - a[row,col] * a[row,row] * x[col];
        x[row] := y[row] / a[row,row];
    end;
end;

var
    a :TwoDimArray = ((5.0,2.0,3.0,4.0),(2.0,10.0,6.0,7.0),(3.0,6.0,15.0,9.0),(4.0,7.0,9.0,20.0));
    b :array [0..N] of Double = (34.0,68.0,96.0,125.0);
    x :array [0..N] of Double = (0.0, 0.0, 0.0, 0.0);
    y :array [0..N] of Double = (0.0, 0.0, 0.0, 0.0);
begin
    writeln('A');
    disp_matrix(a);
    writeln('B');
    disp_vector(b);
    writeln();

    // 前進消去
    forward_elimination(a,b);

    writeln('LDL^T');
    disp_matrix(a);

    // Ly=b から y を求める (前進代入)
    forward_substitution(a,b,y);

    writeln('Y');
    disp_vector(y);

    // DL^Tx=y から x を求める (後退代入)
    backward_substitution(a,y,x);

    writeln('X');
    disp_vector(x);
end.
