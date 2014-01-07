// ‘g‡‚¹
def Comb(n: Int, r: Int): Int = {
    (n, r) match {
        case (_, 0)           => 1
        case (_, 1)           => n
        case (_, _) if n == r => 1
        case (_, _)           => Comb(n - 1, r - 1) + Comb(n - 1, r)
    }
}
// ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”
val n = 10
val r = 5
Comb(n, r)
