-- 組合せ
comb n 0 = 1
comb n 1 = n
comb n r
    | n == r    = 1
    | otherwise = (comb (n - 1) (r - 1)) + (comb (n - 1) r)
-- 異なる 10 個のものから重複を許して 5 個取ってできる組合せの総数
let n = 10
let r = 5
comb (n + r - 1) r
