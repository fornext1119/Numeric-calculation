# ŠKæ‚ğ‹‚ß‚éŠÖ”
def Fact(n)
    if (n <= 1)
        1
    else
        n * Fact(n - 1)
    end
end

# 10‚ÌŠKæ
puts Fact(10)
puts 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1
