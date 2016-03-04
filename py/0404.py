# ‰º~ŠKæ™p
def FallingFact(x, n):
    if (n <= 1):
        return x
    else:
        return x * FallingFact(x - 1, n - 1)

# 10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
print FallingFact(10, 5)
print 10 * 9 * 8 * 7 * 6
