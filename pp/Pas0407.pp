Program Pas0407(arg);
uses
    SysUtils, Math;
var
    n: Integer;
    r: Integer;
begin
    // d•¡‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚çd•¡‚ğ‹–‚µ‚Ä 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
    n := 10;
    r := 5;
    writeln(format('%g', [power(n, r)]));
end.
