def product(m, d, n)
    if (n == 0)
        1
    else
        m * product(m + d, d, n - 1)
    end
end

# ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
puts product(5, 3, 10)
