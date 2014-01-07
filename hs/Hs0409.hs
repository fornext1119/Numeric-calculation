-- ‘g‡‚¹
comb n 0 = 1
comb n 1 = n
comb n r
    | n == r    = 1
    | otherwise = (comb (n - 1) (r - 1)) + (comb (n - 1) r)
-- ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚çd•¡‚ğ‹–‚µ‚Ä 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”
let n = 10
let r = 5
comb (n + r - 1) r
