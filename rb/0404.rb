# ���~�K��p
def FallingFact(x, n)
    if (n <= 1)
        x
    else
        x * FallingFact(x - 1, n - 1)
    end
end

# 10 ���� 6 �܂ł� ����
puts FallingFact(10, 5)
puts 10 * 9 * 8 * 7 * 6
