# ����̑ΐ��֐�
def myLog(x, n, t)
    n2 = n
    x2 = x
    if (n > 3)
        if (n % 2 == 0)
            n2 = 2
        end
        x2 = x * (n / 2)
    end
    t = x2 / (n2 + t)

    if (n <= 2)
        x / (1 + t);
    else
        myLog(x, n - 1, t)
    end
end

(1..20).each do |i|
    x  = i / 5.0
    # �W���̑ΐ��֐�
    d1 = Math.log(x)
    # ����̑ΐ��֐�
    d2 = myLog(x - 1, 27, 0.0) # 27:�K�v�Ȑ��x��������\���傫�Ȋ
    # �W���֐��Ƃ̍���
    printf("%5.2f : %13.10f - %13.10f = %13.10f\n", x, d1, d2, d1 - d2)
end
