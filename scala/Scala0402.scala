// ��������̐�
def prod(m: Long, d: Int, n: Int): Long = {
    n match {
        case 0 => 1
        case _ => m * prod(m + d, d, n - 1)
    }
}
// ���� 5, ���� 3, ���� 10 �̐���̐�
prod(5, 3, 10)
