// �K������߂�֐�
def Fact(n: Int): Int = {
    n match {
        case 0 => 1
        case _ => n * Fact(n - 1)
    }
}
// 10�̊K��
Fact(10)
