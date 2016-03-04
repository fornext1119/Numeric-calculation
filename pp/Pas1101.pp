program Pas1101(arg);
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

// ベキ乗法
function power(a:TwoDimArray; var x0:array of Double):Double;
var
    lambda:Double = 0.0;
    p0, p1, e0, e1:Double;
    i, j, k:Integer;
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

	    // 行列の積 x1 = A × x0
        for i := Low(x1) to High(x1) do
	    	x1[i] := 0.0;
        for i := Low(x1) to High(x1) do
		begin
	        for j := Low(x0) to High(x0) do
	            x1[i] := x1[i] + a[i][j] * x0[j];
	    end;

        // 内積
        p0 := 0.0;
        p1 := 0.0;
        for i := Low(x0) to High(x0) do
        begin
            p0 := p0 + x1[i] * x1[i];
            p1 := p1 + x1[i] * x0[i];
        end;
        // 固有値
        lambda := p0 / p1;

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

    power := lambda;
end;

// ベキ乗法で最大固有値を求める
var
    a :TwoDimArray = ((5.0, 4.0, 1.0, 1.0)
                     ,(4.0, 5.0, 1.0, 1.0)
                     ,(1.0, 1.0, 4.0, 2.0)
                     ,(1.0, 1.0, 2.0, 4.0));
    x :array [0..N] of Double = (1.0, 0.0, 0.0, 0.0);
    lambda:Double;
begin
    // ベキ乗法
    lambda := power(a, x);

    writeln();
    writeln('eigenvalue');
    writeln(format('%14.10f', [lambda]));

    writeln('eigenvector');
    disp_vector(x);
end.
