# ‘g‡‚¹
def Comb(n, r)
    if (r == 0 || r == n)
        1
    elsif (r == 1)
        n
    else
        Comb(n - 1, r - 1) + Comb(n - 1, r)
    end
end

# ‘g‡‚¹ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”)
n = 10
r = 5
puts Comb(n, r)
