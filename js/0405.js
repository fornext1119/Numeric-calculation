// �㏸�K��p
function RisingFact(x, n) {
    if (n <= 1)
        return x
    else
        return x * RisingFact(x + 1, n - 1)
}

// 10 ���� 14 �܂ł� ����
WScript.Echo(RisingFact(10, 5))
WScript.Echo(10 * 11 * 12 * 13 * 14)
