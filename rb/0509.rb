# ����̑o�Ȑ��]���֐�
def myCosh(x, n, numerator, denominator, y)
    m           = 2 * n
    denominator = denominator * m * (m - 1)
    numerator   = numerator * x * x
    a           = numerator / denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a.abs <= 0.00000000001)
        y
    else
        y + myCosh(x, n + 1, numerator, denominator, a)
    end
end

(0..20).each do |i|
    x = i - 10
    # ����̑o�Ȑ��]���֐�
    d1     = myCosh(x, 1, 1.0, 1.0, 1.0)
    # �W���̑o�Ȑ��]���֐�
    d2     = Math.cosh(x)
    # �W���֐��Ƃ̍���
    printf("%3d : %17.10f - %17.10f = %13.10f\n", x, d1, d2, d1 - d2)
end
