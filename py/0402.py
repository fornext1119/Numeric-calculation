def product(m, d, n):
    if (n == 0):
        return 1
    else:
        return m * product(m + d, d, n - 1)

# ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
print product(5, 3, 10)
