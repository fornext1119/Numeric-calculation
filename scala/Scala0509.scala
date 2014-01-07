// ����̑o�Ȑ��]���֐�
def myCosh(x:Double, n:Int, numerator:Double, denominator:Double, y:Double):Double = {
    val m     = 2 * n
    val denom = denominator * m * (m - 1)
    val num   = numerator   * x * x
    val a     = num / denom
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (Math.abs(a) <= 0.00000000001) 
        y
    else
        y + myCosh(x, n + 1, num, denom, a)
}
(0 to 20).
    map(_ - 10).
    foreach { x =>
        // ����̑o�Ȑ��]���֐�
        val d1 = myCosh(x, 1, 1.0, 1.0, 1.0)
        // �W���̑o�Ȑ��]���֐�
        val d2 = Math.cosh(x)
        // �W���֐��Ƃ̍���
        System.out.println("%3d : %17.10f - %17.10f = %13.10f".format(x, d1, d2, d1 - d2));
    }
