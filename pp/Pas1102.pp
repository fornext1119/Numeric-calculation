program Pas1102(arg);
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
// 正規化 (ベクトルの長さを１にする)
procedure normarize(var x:array of Double);
var
    s:Double = 0.0;
    i:Integer;
begin
    for i := Low(x) to High(x) do
        s := s + x[i] * x[i];
    s := Sqrt(s);

    for i := Low(x) to High(x) do
        x[i] := x[i] / s;
end;
// LU分解
procedure forward_elimination(var a:TwoDimArray);
var
    s:Double;
    pivot, row, col:Integer;
begin
    for pivot := Low(a) to High(a) - 1 do
    begin
        for row := (pivot + 1) to High(a) do
        begin
            s := a[row,pivot] / a[pivot,pivot];
            for col := pivot to High(a) do
                a[row,col] := a[row,col] - a[pivot,col] * s; // これが 上三角行列
            a[row,pivot]   := s;                             // これが 下三角行列
        end;
    end;
end;
// 前進代入 (Ly = b から y を求める)
procedure forward_substitution(a:TwoDimArray; var y:array of Double; b:array of Double);
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
// 後退代入 (Ux = y から x を求める)
procedure backward_substitution(a:TwoDimArray; var x:array of Double; var y:array of Double);
var
    row, col:Integer;
begin
    for row := High(a) downto Low(a) do
    begin
        for col := High(a) downto row + 1 do
            y[row] := y[row] - a[row,col] * x[col];
        x[row] := y[row] / a[row,row];
    end;
end;

// 逆ベキ乗法
function inverse(a:TwoDimArray; var x0:array of Double):Double;
var
    lambda:Double = 0.0;
    p0, p1, e0, e1:Double;
    i, k:Integer;
    b:array [0..N] of Double = (0.0, 0.0, 0.0, 0.0);
    y:array [0..N] of Double = (0.0, 0.0, 0.0, 0.0);
    x1:array [0..N] of Double = (0.0, 0.0, 0.0, 0.0);
 begin
    // 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0);
    e0 := 0.0;
    for i := Low(x0) to High(x0) do
        e0 := e0 + x0[i];

    for k := 1 to 100 do
    begin
        // １次元配列を表示
        write(format('%3d'#9, [k]));
        disp_vector(x0);

        // Ly = b から y を求める (前進代入)
        for i := Low(x0) to High(x0) do
        begin
            b[i] := x0[i];
            y[i] := 0;
        end;
        forward_substitution(a,y,b);

        // Ux = y から x を求める (後退代入)
        for i := Low(x1) to High(x1) do
            x1[i] := 0;
        backward_substitution(a,x1,y);

        // 内積
        p0 := 0.0;
        p1 := 0.0;
        for i := Low(x0) to High(x0) do
        begin
            p0 := p0 + x1[i] * x1[i];
            p1 := p1 + x1[i] * x0[i];
        end;
        // 固有値
        lambda := p1 / p0;

        // 正規化 (ベクトル x1 の長さを１にする)
        normarize(x1);
        // 収束判定
        e1 := 0.0;
        for i := Low(x0) to High(x0) do
            e1 := e1 + x1[i];
        if Abs(e1 - e0) < 0.00000000001 then
            break;

        for i := Low(x0) to High(x0) do
            x0[i] := x1[i];
        e0 := e1;
    end;

    inverse := lambda;
end;

// 逆ベキ乗法で最小固有値を求める
var
    a :TwoDimArray = ((5.0, 4.0, 1.0, 1.0)
                     ,(4.0, 5.0, 1.0, 1.0)
                     ,(1.0, 1.0, 4.0, 2.0)
                     ,(1.0, 1.0, 2.0, 4.0));
    x :array [0..N] of Double = (1.0, 0.0, 0.0, 0.0);
    lambda:Double;
begin
    // LU分解
    forward_elimination(a);

    // 逆ベキ乗法
    lambda := inverse(a, x);

    writeln();
    writeln('eigenvalue');
    writeln(format('%14.10f', [lambda]));

    writeln('eigenvector');
    disp_vector(x);
end.
