# ����̐��ڊ֐�
def myTan(x, x2, n, t)
    t = x2 / (n - t)
    n -= 2
    if (n <= 1)
        x / (1 - t)
    else
        myTan(x, x2, n, t)
    end
end

(0..12).each do |i|
    if i * 15 % 180 != 0
        degree = i * 15 - 90
        radian = degree * Math::PI / 180
        x2     = radian * radian
        # ����̐��ڊ֐�
        d1     = myTan(radian, x2, 15, 0.0) # 15:�K�v�Ȑ��x��������\���傫�Ȋ
        # �W���̐��ڊ֐�
        d2     = Math.tan(radian)
        # �W���֐��Ƃ̍���
        printf("%3d : %13.10f - %13.10f = %13.10f\n", degree, d1, d2, d1 - d2)
    end
end
