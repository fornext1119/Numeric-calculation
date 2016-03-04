Program Pas0508(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
function mySinh(x:Double; n:Integer; numerator:Double; denominator:Double; y:Double):Double;
var
    m: Integer;
    a: Double;
begin
    m           := 2 * n;
    denominator := denominator * (m + 1) * m;
    numerator   := numerator   * x * x;
    a           := numerator / denominator;
    // \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ğ”²‚¯‚é
    if (Abs(a) <= 0.00000000001) then
        result := y
    else
        result := y + mySinh(x, n + 1, numerator, denominator, a);
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
        // ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
        d1 := mySinh(x, 1, x, 1.0, x);
        // •W€‚Ì‘o‹Èü³Œ·ŠÖ”
        d2 := Sinh(x);
        // •W€ŠÖ”‚Æ‚Ì·ˆÙ
        writeln(format('%3d : %17.10f - %17.10f = %13.10f', [x, d1, d2, d1 - d2]));
    end;
end.
