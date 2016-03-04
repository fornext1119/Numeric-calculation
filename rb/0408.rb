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

# 組合せ (異なる 10 個のものから 5 個取ってできる組合せの総数)
n = 10
r = 5
puts Comb(n, r)
