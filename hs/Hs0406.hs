-- ŠKæ
fact 0 = 1
fact n = n * fact (n-1)
-- ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
let n = 10
let r = 5
(fact n) `div` (fact (n - r))
-- ‰º~ŠKæ™p
fallingFact x 1 = x
fallingFact x n = x * (fallingFact (x - 1) (n - 1))
-- ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
let n = 10
let r = 5
fallingFact n r
