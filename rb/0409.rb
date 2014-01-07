# 組合せ
def Comb(n, r)
    if (r == 0 || r == n)
        1
    elsif (r == 1)
        n
    else
        Comb(n - 1, r - 1) + Comb(n - 1, r)
    end
end

# 重複組合せ (異なる 10 個のものから重複を許して 5 個とる組合せの総数)
n = 10
r = 5
puts Comb(n + r - 1, r)
