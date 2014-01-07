-- “™·”—ñ‚ÌÏ
prod m d 0 = 1
prod m d n =  m * (prod (m + d) d (n - 1))
-- ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ
prod 5 3 10
