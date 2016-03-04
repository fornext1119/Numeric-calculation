program Pas1103(arg);
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
                s := s + (a[i][k] * b[k][j]);
            c[i][j] := s;
        end;
    end;
end;

// LU分解
procedure decomp(a:TwoDimArray; var l:TwoDimArray; var u:TwoDimArray);
var
    i, j, k:Integer;
    t:Double;
begin
    for i := 0 to N do
    begin
        for j := 0 to N do
        begin
            l[i][j] := 0.0;
            u[i][j] := 0.0;
        end;
    end;

    l[0][0] := 1.0;
    for j := 0 to N do
        u[0][j] := a[0][j];

    for i := 1 to N do
    begin
        u[i][0] := 0.0;
        l[0][i] := 0.0;
        l[i][0] := a[i][0] / u[0][0];
    end;
    for i := 1 to N do
    begin
        l[i][i] := 1.0;
        t := a[i][i];
        for k := 0 to i do
            t := t - (l[i][k] * u[k][i]);
        u[i][i] := t;
        for j := (i + 1) to N do
        begin
            u[j][i] := 0.0;
            l[i][j] := 0.0;
            t       := a[j][i];
            for k := 0 to i do
                t := t - (l[j][k] * u[k][i]);
            l[j][i] := t / u[i][i];
            t       := a[i][j];
            for k := 0 to i do
                t := t - (l[i][k] * u[k][j]);
            u[i][j] := t;
        end;
    end;
end;

// LR分解で固有値を求める
var
    a :TwoDimArray = ((5.0, 4.0, 1.0, 1.0)
                     ,(4.0, 5.0, 1.0, 1.0)
                     ,(1.0, 1.0, 4.0, 2.0)
                     ,(1.0, 1.0, 2.0, 4.0));
    l :TwoDimArray = ((0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0));
    u :TwoDimArray = ((0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0)
                     ,(0.0, 0.0, 0.0, 0.0));
    e:Double;
    i, j, k:Integer;
begin
    for k := 1 to 200 do
    begin
        // LU分解
        decomp(a, l, u);
        // 行列の積
        multiply(u, l, a);
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
