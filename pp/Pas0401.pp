Program Pas0401(arg);
const
    a:Integer = 5;  // ���� 5
    d:Integer = 3;  // ���� 3
    n:Integer = 10; // ���� 10
var
    p:Int64   = 1;  // ��
    m:Integer;
    i:Integer;
begin
    for i := 1 to n do
    begin
        m := a + (d * (i - 1));
        p := p * m;
    end;
    writeln(p);
end.
