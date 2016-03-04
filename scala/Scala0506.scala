// ����̑ΐ��֐�
def myLog(x2:Double, numerator:Double, denominator:Double, y:Double):Double = {
    val denom = denominator + 2
    val num   = numerator   * x2 * x2
    val a     = num / denom
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (Math.abs(a) <= 0.00000000001)
        y
    else
        y + myLog(x2, num, denom, a)
}
(1 to 20).
    map(_ / 5.0).
    foreach { x =>
        // �W���̑ΐ��֐�
        val d1 = Math.log(x)
        // ����̑ΐ��֐�
        val x2 = (x - 1) / (x + 1)
        val d2 = 2 * myLog(x2, x2, 1.0, x2)
        // �W���֐��Ƃ̍���
        System.out.println("%5.2f : %13.10f - %13.10f = %13.10f".format(x, d1, d2, d1 - d2))
    }
