def product(m, d, n)
    if (n == 0)
        1
    else
        m * product(m + d, d, n - 1)
    end
end

# ���� 5, ���� 3, ���� 10 �̐���̐ς�\������
puts product(5, 3, 10)
