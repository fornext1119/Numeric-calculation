Program Pas0702(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    // データ点の数 - 1
    N = 6;

// 元の関数
function f(x:Double):Double;
begin
    result := x - power(x,3) / (3 * 2) + power(x,5) / (5 * 4 * 3 * 2);
end;

// Neville (ネヴィル) 補間
function neville(d:Double; x:array of Double; y:array of Double):Double;
var
    w :array [0..N, 0..N] of Double;
    i, j      :Integer;
begin
    for i := Low(y) to High(y) do
        w[0,i] := y[i];

    for j := 1 to High(x) do
    begin
        for i := Low(x) to (High(x) - j) do
            w[j,i] := w[j-1,i+1] + (w[j-1,i+1] - w[j-1,i]) * (d - x[i+j]) / (x[i+j] - x[i]);
    end;
    result := w[N,0];
end;

var
    i :Integer;
    x :array [0..N] of Double;
    y :array [0..N] of Double;
    d, d1, d2 :Double;
begin
    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for i := Low(x) to High(x) do
    begin
        d    := i * 1.5 - 4.5;
        x[i] := d;
        y[i] := f(d);
    end;

    // 0.5刻みで 与えられていない値を補間
    for i := 0 to 18 do
    begin
        d  := i * 0.5 - 4.5;
        d1 := f(d);
        d2 := neville(d, x, y);

        // 元の関数と比較
        writeln(format('%5.2f'#9'%8.5f'#9'%8.5f'#9'%8.5f', [d, d1, d2, d1 - d2]));
    end;
end.
