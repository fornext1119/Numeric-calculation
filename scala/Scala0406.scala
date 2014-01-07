// ŠKæ
def Fact(n: Int): Int = {
    n match {
        case 0 => 1
        case _ => n * Fact(n - 1)
    }
}
// ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂŽæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
val n = 10
val r = 5
Fact(n) / Fact(n - r)
// ‰º~ŠKæ™p
def FallingFact(x: Int, n: Int): Int = {
    n match {
        case 1 => x
        case _ => x * FallingFact(x - 1, n - 1)
    }
}
// ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂŽæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
val n = 10
val r = 5
FallingFact(n, r)
