// 階乗
function Fact(n) {
    if (n <= 1)
        return 1
    else
        return n * Fact(n - 1)
}

// 下降階乗冪
function FallingFact(x, n) {
    if (n <= 1)
        return x
    else
        return x * FallingFact(x - 1, n - 1)
}

// 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
var n = 10
var r = 5
WScript.Echo(Fact(n) / Fact(n - r))
WScript.Echo(FallingFact(n, r))
