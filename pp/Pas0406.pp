Program Pas0406(arg);
uses
    SysUtils;

    // �K��
    function Fact(n: Integer): Longint;
    begin
        if n <= 1 then
            Fact := 1
        else
            Fact := n * Fact(n - 1);
    end;

    // ���~�K��p
    function FallingFact(x: Integer; n: Integer): Longint;
    begin
        if n <= 1 then
            FallingFact := x
        else
            FallingFact := x * FallingFact(x - 1, n - 1);
    end;

var
    n: Integer;
    r: Integer;
begin
    // ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
    n := 10;
    r := 5;
    writeln(format('%g', [Fact(n) / Fact(n - r)]));
    writeln(FallingFact(n, r));
end.
