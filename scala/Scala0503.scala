// ����̐��ڊ֐�
def myTan(x:Double, x2:Double, n:Int, t:Double):Double = {
    val denom = x2 / (n - t)
    val num   = n - 2
    if (num <= 1) 
        x / (1 - denom)
    else
        myTan(x, x2, num, denom)
}
(0 to 12).
    map(_ * 15).
    filter(n => n % 180 != 0).
    map(_ - 90).
    foreach { degree =>
        val radian = Math.toRadians(degree)
        val x2     = radian * radian
        // ����̐��ڊ֐�
        val d1 = myTan(radian, x2, 15, 0.0) // 15:�K�v�Ȑ��x��������\���傫�Ȋ
        // �W���̐��ڊ֐�
        val d2 = Math.tan(radian)
        // �W���֐��Ƃ̍���
        System.out.println("%3d : %13.10f - %13.10f = %13.10f".format(degree, d1, d2, d1 - d2));
    }
