-- ‰º~ŠKæ™p
fallingFact x 1 = x
fallingFact x n = x * (fallingFact (x - 1) (n - 1))
-- 10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
fallingFact 10 5
