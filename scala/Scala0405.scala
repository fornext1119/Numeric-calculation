// �㏸�K��p
def RisingFact(x: Int, n: Int): Int = {
    n match {
        case 1 => x
        case _ => x * RisingFact(x + 1, n - 1)
    }
}
// 10 ���� 14 �܂ł� ����
RisingFact(10, 5)
