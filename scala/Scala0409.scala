// 組合せ
def Comb(n: Int, r: Int): Int = {
    (n, r) match {
        case (_, 0)           => 1
        case (_, 1)           => n
        case (_, _) if n == r => 1
        case (_, _)           => Comb(n - 1, r - 1) + Comb(n - 1, r)
    }
}
// 異なる 10 個のものから重複を許して 5 個とる組合せの総数
val n = 10
val r = 5
Comb(n + r - 1, r)
