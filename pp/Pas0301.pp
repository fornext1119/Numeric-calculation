Program Pas0301(arg);
{$MODE delphi}

// ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
function sn(a:Integer; lim:Integer):Integer;
var
    n, l:Integer;
begin
    n := lim div a;               // €”:n  =  ãŒÀ:lim / Œö·:a
    l := n * a;                   // ––€:l  =  €”:n   * Œö·:a
    result := (a + l) * n div 2;  // ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
end;

begin
    // 3 ‚Ì”{”‚Ì‡Œv
    writeln(sn(3, 999));
end.
