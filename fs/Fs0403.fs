// �K������߂�֐�
let rec Fact = function
    |   0 -> 1
    |   n -> n * Fact(n - 1)
// 10�̊K��
Fact 10
