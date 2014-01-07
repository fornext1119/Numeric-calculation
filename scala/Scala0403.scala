// ŠKæ‚ğ‹‚ß‚éŠÖ”
def Fact(n: Int): Int = {
    n match {
        case 0 => 1
        case _ => n * Fact(n - 1)
    }
}
// 10‚ÌŠKæ
Fact(10)
