// �K������߂�֐�
function Fact(n) {
    if (n <= 1)
        return 1
    else
        return n * Fact(n - 1)
}

// 10�̊K��
WScript.Echo(Fact(10))
WScript.Echo(10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1)
