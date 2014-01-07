Program Pas0504(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// 自作の指数関数
function myExp(x:Double; n:Integer; numerator:Double; denominator:Double; y:Double):Double;
var
    a: Double;
begin
    denominator := denominator * n;
    numerator   := numerator   * x;
    a           := numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (Abs(a) <= 0.00000000001) then
        result := y
    else
        result := y + myExp(x, n + 1, numerator, denominator, a);
end;

var
    i:  Integer;
    x:  Double;
    d1: Double;
    d2: Double;
begin
    for i := 0 to 20 do
    begin
        x  := (i - 10) / 4.0;
        // 標準の指数関数
        d1 := Exp(x);
        // 自作の指数関数
        d2 := myExp(x, 1, 1.0, 1.0, 1.0);
        // 標準関数との差異
        writeln(format('%5.2f : %13.10f - %13.10f = %13.10f', [x, d1, d2, d1 - d2]));
    end;
end.
