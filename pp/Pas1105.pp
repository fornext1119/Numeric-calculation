program Pas1105(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    N = 3;

type
    TwoDimArray = array [0..N,0..N] of Double;

// 対角要素を表示
procedure disp_eigenvalue(a:TwoDimArray);
var
    i:Integer;
begin
    for i := 0 to N do
        write(format('%14.10f'#9, [a[i][i]]));
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

// １次元配列を表示
procedure disp_vector(row:array of Double);
var
    i:Integer;
begin
    for i := Low(row) to High(row) do
        write(format('%14.10f'#9, [row[i]]));
    writeln();
end;

// 固有ベクトルを表示
procedure disp_eigenvector(matrix:TwoDimArray);
var
    i, j:Integer;
    row:array [0..N] of Double;
begin
    for i := 0 to N do
    begin
        for j := 0 to N do
			row[j] := matrix[i][j];
        normarize(row);
        disp_vector(row);
    end;
end;

// ヤコビ法
procedure jacobi(var a:TwoDimArray; var v:TwoDimArray);
var
    i, j, k:Integer;
    p, q:Integer;
    max_val:Double;
    c, s:Double;
    t, t1, t2:Double;
begin
    for k := 1 to 100 do
    begin
        // 最大値を探す
        max_val := 0.0;
        for i := 0 to N do
        begin
            for j := i + 1 to N do
            begin
                if (max_val < Abs(a[i][j])) then
                begin
                    max_val := Abs(a[i][j]);
                    p := i;
                    q := j;
                end;
            end;
        end;

        // θ を求める
        t := 0.0;
        if Abs(a[p][p] - a[q][q]) < 0.00000000001 then
        begin
            // a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
            t := PI / 4.0;
            if (a[p][p] < 0) Then
                t := -t;
        end
        else
        begin
            // a_{pp} ≠ a_{qq} のとき
            t := Arctan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0;
        end;

        // θ を使って 行列 U を作成し、A = U^t × A × U
        c := Cos(t);
        s := Sin(t);
        // U^t × A
        t1 := 0.0;
        t2 := 0.0;
        for i := 0 to N do
        begin
            t1      :=  a[p][i] * c + a[q][i] * s;
            t2      := -a[p][i] * s + a[q][i] * c;
            a[p][i] := t1;
            a[q][i] := t2;
            // 固有ベクトル
            t1      :=  v[p][i] * c + v[q][i] * s;
            t2      := -v[p][i] * s + v[q][i] * c;
            v[p][i] := t1;
            v[q][i] := t2;
        end;
        // A × U
        for i := 0 to N do
        begin
            t1      :=  a[i][p] * c + a[i][q] * s;
            t2      := -a[i][p] * s + a[i][q] * c;
            a[i][p] := t1;
            a[i][q] := t2;
        end;

        // 対角要素を表示
        write(format('%3d'#9, [k]));
        disp_eigenvalue(a);

        // 収束判定
    	if max_val < 0.00000000001 then break;
    end;
end;

// ヤコビ法で固有値を求める
var
    a :TwoDimArray = ((5.0, 4.0, 1.0, 1.0)
                     ,(4.0, 5.0, 1.0, 1.0)
                     ,(1.0, 1.0, 4.0, 2.0)
                     ,(1.0, 1.0, 2.0, 4.0));

    v :TwoDimArray = ((1.0 ,0.0 ,0.0 ,0.0),
                      (0.0 ,1.0 ,0.0 ,0.0),
                      (0.0 ,0.0 ,1.0 ,0.0),
                      (0.0 ,0.0 ,0.0 ,1.0));
begin
	// ヤコビ法
	jacobi(a, v);

    writeln();
    writeln('eigenvalue');
	disp_eigenvalue(a);

    writeln();
    writeln('eigenvector');
	disp_eigenvector(v);
end.
