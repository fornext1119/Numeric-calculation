# ����̎w���֐�
def myExp(x, n, numerator, denominator, y)
    denominator = denominator * n
    numerator   = numerator   * x
    a           = numerator / denominator;
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a.abs <= 0.00000000001)
        y
    else
        y + myExp(x, n + 1, numerator, denominator, a)
    end
end

(0..20).each do |i|
    x  = (i - 10) / 4.0
    # �W���̎w���֐�
    d1 = Math.exp(x)
    # ����̎w���֐�
    d2 = myExp(x, 1, 1.0, 1.0, 1.0)
    # �W���֐��Ƃ̍���
    printf("%5.2f : %13.10f - %13.10f = %13.10f\n", x, d1, d2, d1 - d2)
end
