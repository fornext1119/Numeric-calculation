# 階乗
def Fact(n)
    if (n <= 1)
        1
    else
        n * Fact(n - 1)
    end
end

# 下降階乗冪
def FallingFact(x, n)
    if (n <= 1)
        x
    else
        x * FallingFact(x - 1, n - 1)
    end
end

# 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
n = 10
r = 5
puts Fact(n) / Fact(n - r)
puts FallingFact(n, r)
