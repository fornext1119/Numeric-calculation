# �g����
def Comb(n, r)
    if (r == 0 || r == n)
        1
    elsif (r == 1)
        n
    else
        Comb(n - 1, r - 1) + Comb(n - 1, r)
    end
end

# �d���g���� (�قȂ� 10 �̂��̂���d���������� 5 �Ƃ�g�����̑���)
n = 10
r = 5
puts Comb(n + r - 1, r)
