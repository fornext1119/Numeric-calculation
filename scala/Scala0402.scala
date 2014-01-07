// “™·”—ñ‚ÌÏ
def prod(m: Long, d: Int, n: Int): Long = {
    n match {
        case 0 => 1
        case _ => m * prod(m + d, d, n - 1)
    }
}
// ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ
prod(5, 3, 10)
