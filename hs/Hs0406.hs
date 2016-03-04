-- 階乗
fact 0 = 1
fact n = n * fact (n-1)
-- 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
let n = 10
let r = 5
(fact n) `div` (fact (n - r))
-- 下降階乗冪
fallingFact x 1 = x
fallingFact x n = x * (fallingFact (x - 1) (n - 1))
-- 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
let n = 10
let r = 5
fallingFact n r
