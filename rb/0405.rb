# �㏸�K��p
def RisingFact(x, n)
    if (n <= 1)
        x
    else
        x * RisingFact(x + 1, n - 1)
    end
end

# 10 ���� 14 �܂ł� ����
puts RisingFact(10, 5)
puts 10 * 11 * 12 * 13 * 14
