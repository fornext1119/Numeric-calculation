-- ã¸ŠKæ™p
risingFact x 1 = x
risingFact x n = x * (risingFact (x + 1) (n - 1))
-- 10 ‚©‚ç 14 ‚Ü‚Å‚Ì ‘æ
risingFact 10 5
