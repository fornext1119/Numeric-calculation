// ����:a, ����:a �� ���:lim �̐���̑��a��Ԃ��֐�
function sn(a, lim) {
    var n = parseInt(lim / a) // ����:n  =  ���:lim / ����:a
    var l = n * a             // ����:l  =  ����:n   * ����:a
    return (a + l) * n / 2    // ���a:sn = (����:a   + ����:l) * ����:n / 2
}

// 3 �̔{���̍��v
WScript.Echo(sn(3, 999))
