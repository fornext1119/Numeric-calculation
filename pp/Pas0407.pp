Program Pas0407(arg);
uses
    SysUtils, Math;
var
    n: Integer;
    r: Integer;
begin
    // �d������ (�قȂ� 10 �̂��̂���d���������� 5 ����Ăł��鏇��̑���)
    n := 10;
    r := 5;
    writeln(format('%g', [power(n, r)]));
end.
