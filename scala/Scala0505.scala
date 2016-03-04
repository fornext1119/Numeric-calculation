// ����̎w���֐�
def myExp(x:Double, x2:Double, n:Int, t:Double):Double = {
    val denom = x2 / (n + t)
    val num   = n - 4  

    if (num < 6)
        1 + ((2 * x) / (2 - x + denom))
    else
        myExp(x, x2, num, denom)
}
(0 to 20).
    map(n => (n - 10) / 4.0).
    foreach { x =>
        // �W���̎w���֐�
        val d1 = Math.exp(x)
        // ����̎w���֐�
        val x2 = x * x
        val d2 = myExp(x, x2, 30, 0.0) // 30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
        // �W���֐��Ƃ̍���
        System.out.println("%5.2f : %13.10f - %13.10f = %13.10f".format(x, d1, d2, d1 - d2))
    }
