program Pas1004(arg);
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
    pivot, row, col:Integer;
begin
    for pivot := Low(a) to High(a) do
    begin
        for row := Low(a) to High(a) do
        begin
            if row = pivot then continue;
            
            s := a[row,pivot] / a[pivot,pivot];
            for col := pivot to High(a) do
                a[row,col] := a[row,col] - a[pivot,col] * s;
            b[row]         := b[row]     - b[pivot]     * s;
        end;
    end;
end;
// 後退代入
procedure backward_substitution(a:TwoDimArray; var b:array of Double); 
var
    pivot:Integer;
begin
    for pivot := Low(a) to High(a) do
        b[pivot] := b[pivot] / a[pivot,pivot];
end;

// ピボット選択
procedure pivoting(var a:TwoDimArray; var b:array of Double);
var
    max_val, tmp:Double;
    pivot, row, col, max_row:Integer;
begin
    for pivot := Low(a) to High(a) do
    begin
        // 各列で 一番値が大きい行を 探す
        max_row :=   pivot;
        max_val :=   0;
        for row := pivot to High(a) do
        begin
            if abs(a[row,pivot]) > max_val then
            begin
                // 一番値が大きい行
                max_val :=   abs(a[row,pivot]);
                max_row :=   row;
            end;
        end;

        // 一番値が大きい行と入れ替え
        if max_row <> pivot then
        begin
            tmp := 0;
            for col := Low(a) to High(a) do
            begin
                tmp            :=   a[max_row,col];
                a[max_row,col] :=   a[pivot,col];
                a[pivot,col]   :=   tmp;
            end;
            tmp        :=   b[max_row];
            b[max_row] :=   b[pivot];
            b[pivot]   :=   tmp;
        end;
    end;
end;

var
    a :TwoDimArray = (( 9.0,  2.0, 1.0,  1.0), (2.0, 8.0, -2.0, 1.0), (-1.0, -2.0, 7.0, -2.0), (1.0, -1.0, -2.0, 6.0));
    b :array [0..N] of Double = (20.0, 16.0, 8.0, 17.0);
begin
    // ピボット選択
    pivoting(a,b);

    writeln('pivoting');
    writeln('A');
    disp_matrix(a);
    writeln('B');
    disp_vector(b);
    writeln();

    // 前進消去
    forward_elimination(a,b);

    writeln('forward elimination');
    writeln('A');
    disp_matrix(a);
    writeln('B');
    disp_vector(b);
    writeln();

    // 後退代入
    backward_substitution(a,b);

    writeln('X');
    disp_vector(b);
end.
