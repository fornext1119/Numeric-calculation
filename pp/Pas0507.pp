Program Pas0507(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// 自作の対数関数
function myLog(x:Double; n:Integer; t:Double):Double;
var
    n2 :Integer;
    x2 :Double;
begin
    n2 := n;
    x2 := x;
    if (n > 3) then
    begin
        if (n Mod 2 = 0) then
            n2 := 2;
        x2 := x * (n Div 2);
    end;
    t := x2 / (n2 + t);

    if (n <= 2) then
        result := x / (1 + t)
    else
        result := myLog(x, n - 1, t);
end;

var
    i:  Integer;
    x:  Double;
    d1: Double;
    d2: Double;
begin
    for i := 1 to 20 do
    begin
        x  := i / 5.0;
        // 標準の対数関数
        d1 := Ln(x);
        // 自作の対数関数
        d2 := myLog(x - 1, 27, 0.0); // 27:必要な精度が得られる十分大きな奇数
        // 標準関数との差異
        writeln(format('%5.2f : %13.10f - %13.10f = %13.10f', [x, d1, d2, d1 - d2]));
    end;
end.
