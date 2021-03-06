// 階乗
def Fact(n: Int): Int = {
    n match {
        case 0 => 1
        case _ => n * Fact(n - 1)
    }
}
// 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
val n = 10
val r = 5
Fact(n) / Fact(n - r)
// 下降階乗冪
def FallingFact(x: Int, n: Int): Int = {
    n match {
        case 1 => x
        case _ => x * FallingFact(x - 1, n - 1)
    }
}
// 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
val n = 10
val r = 5
FallingFact(n, r)
