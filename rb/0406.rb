# �K��
def Fact(n)
    if (n <= 1)
        1
    else
        n * Fact(n - 1)
    end
end

# ���~�K��p
def FallingFact(x, n)
    if (n <= 1)
        x
    else
        x * FallingFact(x - 1, n - 1)
    end
end

# ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
n = 10
r = 5
puts Fact(n) / Fact(n - r)
puts FallingFact(n, r)
