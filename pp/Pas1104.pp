program Pas1104(arg);
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

// 行列の積
procedure multiply(a:TwoDimArray; b:TwoDimArray; var c:TwoDimArray);
var
    i, j, k:Integer;
    s:Double;
begin
    for i := 0 to N do
    begin
        for j := 0 to N do
        begin
            s := 0.0;
            for k := 0 to N do
                s := s + a[i][k] * b[k][j];
            c[i][j] := s;
        end;
    end;
end;

// QR分解
procedure decomp(a:TwoDimArray; var q:TwoDimArray; var r:TwoDimArray);
var
    i, j, k:Integer;
    t, s:Double;
    x :array [0..N] of Double;
begin
    for k := 0 to N do
    begin
        for i := 0 to N do
            x[i] := a[i][k];
        for j := 0 to (k - 1) do
        begin
            t := 0.0;
            for i := 0 to N do
                t := t + a[i][k] * q[i][j];
            r[j][k] := t;
            r[k][j] := 0.0;
            for i := 0 to N do
                x[i] := x[i] - t * q[i][j];
        end;
        
        s := 0.0;
        for i := 0 to N do
            s := s + x[i] * x[i];
        r[k][k] := Sqrt(s);        
        for i := 0 to N do
            q[i][k] := x[i] / r[k][k];
    end;
end;

// QR分解で固有値を求める
var
    a :TwoDimArray = ((5.0, 4.0, 1.0, 1.0)
                     ,(4.0, 5.0, 1.0, 1.0)
                     ,(1.0, 1.0, 4.0, 2.0)
                     ,(1.0, 1.0, 2.0, 4.0));
    q :TwoDimArray = ((0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0));
    r :TwoDimArray = ((0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0));
    e:Double;
    i, j, k:Integer;
begin
    for k := 1 to 200 do
    begin
        // QR分解
        decomp(a, q, r);
        // 行列の積
        multiply(r, q, a);
        // 対角要素を表示
        write(format('%3d'#9, [k]));
        disp_eigenvalue(a);

        // 収束判定
        e := 0.0;
        for i := 1 to N do
        begin
            for j := 0 to (i - 1) do
                e := e + Abs(a[i][j]);
        end;
        if e < 0.00000000001 then
            break;
    end;

    writeln();
    writeln('eigenvalue');
    disp_eigenvalue(a);
end.
