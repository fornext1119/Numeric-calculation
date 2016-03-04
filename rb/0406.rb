# ŠKæ
def Fact(n)
    if (n <= 1)
        1
    else
        n * Fact(n - 1)
    end
end

# ‰º~ŠKæ™p
def FallingFact(x, n)
    if (n <= 1)
        x
    else
        x * FallingFact(x - 1, n - 1)
    end
end

# ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
n = 10
r = 5
puts Fact(n) / Fact(n - r)
puts FallingFact(n, r)
