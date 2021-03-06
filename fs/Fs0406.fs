// 階乗
let rec Fact = function
    |   0 -> 1
    |   n -> n * Fact(n - 1)
// 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
let n = 10
let r = 5
Fact n / Fact (n - r)
// 下降階乗冪
let rec FallingFact (x:int) (n:int):int =
    match n with
        | 1 -> x
        | _ -> x * (FallingFact (x - 1) (n - 1))
// 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
let n = 10
let r = 5
FallingFact n r
