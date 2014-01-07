# ����̐����֐�
def mySin(x, n, nega, numerator, denominator, y)
    m           = 2 * n
    denominator = denominator * (m + 1) * m
    numerator   = numerator * x * x
    a           = numerator / denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a <= 0.00000000001)
        y
    else
        y + mySin(x, n + 1, !nega, numerator, denominator, nega ? a : -a)
    end
end

(1..24).each do |i|
    degree = i * 15
    if degree % 30 == 0 || degree % 45 == 0
        radian = degree * Math::PI / 180
        # ����̐����֐�
        d1     = mySin(radian, 1, false, radian, 1.0, radian)
        # �W���̐����֐�
        d2     = Math.sin(radian)
        # �W���֐��Ƃ̍���
        printf("%3d : %13.10f - %13.10f = %13.10f\n", degree, d1, d2, d1 - d2)
    end
end
