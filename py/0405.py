# ã¸ŠKæ™p
def RisingFact(x, n):
    if (n <= 1):
        return x
    else:
        return x * RisingFact(x + 1, n - 1)

# 10 ‚©‚ç 14 ‚Ü‚Å‚Ì ‘æ
print RisingFact(10, 5)
print 10 * 11 * 12 * 13 * 14
