Program Pas0409(arg);
    
    // �g����
    function Comb(n: Integer; r: Integer): Longint;
    begin
        if (r = 0) or (r = n) then
            Comb := 1
        else if r = 1 then
            Comb := n
        else
            Comb := Comb(n - 1, r - 1) + Comb(n - 1, r);
    end;

var
    n: Integer;
    r: Integer;
begin
    // �d���g���� (�قȂ� 10 �̂��̂���d���������� 5 �Ƃ�g�����̑���)
    n := 10;
    r := 5;
    writeln(Comb(n + r - 1, r));
end.
