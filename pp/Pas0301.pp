Program Pas0301(arg);
{$MODE delphi}

// ����:a, ����:a ��, ���:lim �̐���̑��a��Ԃ��֐�
function sn(a:Integer; lim:Integer):Integer;
var
    n, l:Integer;
begin
    n := lim div a;               // ����:n  =  ���:lim / ����:a
    l := n * a;                   // ����:l  =  ����:n   * ����:a
    result := (a + l) * n div 2;  // ���a:sn = (����:a   + ����:l) * ����:n / 2
end;

begin
    // 3 �̔{���̍��v
    writeln(sn(3, 999));
end.
