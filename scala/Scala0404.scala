// ���~�K��p
def FallingFact(x: Int, n: Int): Int = {
    n match {
        case 1 => x
        case _ => x * FallingFact(x - 1, n - 1)
    }
}
// 10 ���� 6 �܂ł� ����
FallingFact(10, 5)
