Program Pas0509(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// 自作の双曲線余弦関数
function myCosh(x:Double; n:Integer; numerator:Double; denominator:Double; y:Double):Double;
var
    m: Integer;
    a: Double;
begin
    m           := 2 * n;
    denominator := denominator * m * (m - 1);
    numerator   := numerator   * x * x;
    a           := numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (Abs(a) <= 0.00000000001) then
        result := y
    else
        result := y + myCosh(x, n + 1, numerator, denominator, a);
end;

var
    i:  Integer;
    x:  Integer;
    d1: Double;
    d2: Double;
begin
    for i := 0 to 20 do
    begin
        x  := i - 10;
        // 自作の双曲線余弦関数
        d1 := myCosh(x, 1, 1.0, 1.0, 1.0);
        // 標準の双曲線余弦関数
        d2 := Cosh(x);
        // 標準関数との差異
        writeln(format('%3d : %17.10f - %17.10f = %13.10f', [x, d1, d2, d1 - d2]));
    end;
end.
