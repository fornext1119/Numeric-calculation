Program Pas0304(arg);
uses
    SysUtils, Math;
var
    n:Integer;
begin
    // 10000 �܂ł� ��̘a
    // ���ڐ� n = 5000
    n := 10000 div 2;
    writeln( format('%g', [power(n, 2)]) ); // power �� Extended �^
end.
