Program Pas0405(arg);

    // �㏸�K��p
    function RisingFact(x: Integer; n: Integer): Longint;
    begin
        if n <= 1 then
            RisingFact := x
        else
            RisingFact := x * RisingFact(x + 1, n - 1);
    end;

begin
    // 10 ���� 14 �܂ł� ����
    writeln(RisingFact(10, 5));
    writeln(10 * 11 * 12 * 13 * 14);
end.
