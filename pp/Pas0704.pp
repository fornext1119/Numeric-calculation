Program Pas0704(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    // データ点の数 - 1
    N   =  6;
    Nx2 = 13;

// 元の関数
function f(x:Double):Double;
begin
    result := x - power(x,3) / (3 * 2) + power(x,5) / (5 * 4 * 3 * 2);
end;

// 導関数
function fd(x:Double):Double;
begin
    result := 1 - power(x,2) / 2 + power(x,4) / (4 * 3 * 2);
end;

// Hermite (エルミート) 補間
function hermite(d:Double; z:array of Double; a:array of Double):Double;
var
    sum, prod :Double;
    i, j      :Integer;
begin
    sum := a[0];
    for i := 1 to High(a) do
    begin
        prod := a[i];
        for j := Low(z) to i-1 do
            prod := prod * (d - z[j]);
        sum := sum + prod;
    end;
    result := sum;
end;

var
    i, j :Integer;
    x  :array [0..N] of Double;
    y  :array [0..N] of Double;
    yd :array [0..N] of Double;
    z  :array [0..Nx2] of Double;
    a  :array [0..Nx2] of Double;
    d  :array [0..Nx2, 0..Nx2] of Double;
    d1, d2, d3 :Double;
begin
    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for i := Low(x) to High(x) do
    begin
        d1    := i * 1.5 - 4.5;
        x[i]  := d1;
        y[i]  := f(d1);
        yd[i] := fd(d1);
    end;

    // 差分商の表を作る
    for i := Low(z) to High(z) do
    begin
        j      := i div 2;
        z[i]   := x[j];
        d[0,i] := y[j];
    end;

    for i := 1 to High(z) do
    begin
        for j := Low(z) to High(z)-i do
	    begin
            if (i = 1) and (j mod 2 = 0) then
                d[i,j] := yd[j div 2]
            else
                d[i,j] := (d[i-1,j+1] - d[i-1,j]) / (z[j+i] - z[j]);
	    end;
    end;

    // ｎ階差分商
    for j := Low(a) to High(a) do
        a[j] := d[j,0];

    // 0.5刻みで 与えられていない値を補間 
    for i := 0 to 18 do
    begin
        d1 := i * 0.5 - 4.5;
        d2 := f(d1);
        d3 := hermite(d1, z, a);

        // 元の関数と比較
        writeln(format('%5.2f'#9'%8.5f'#9'%8.5f'#9'%8.5f', [d1, d2, d3, d2 - d3]));
    end;
end.
