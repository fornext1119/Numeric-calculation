// ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
def mySinh(x:Double, n:Int, numerator:Double, denominator:Double, y:Double):Double = {
    val m     = 2 * n
    val denom = denominator * (m + 1) * m
    val num   = numerator   * x * x
    val a     = num / denom
    // \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ğ”²‚¯‚é
    if (Math.abs(a) <= 0.00000000001) 
        y
    else
        y + mySinh(x, n + 1, num, denom, a)
}
(0 to 20).
    map(_ - 10).
    foreach { x =>
        // ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
        val d1 = mySinh(x, 1, x, 1.0, x)
        // •W€‚Ì‘o‹Èü³Œ·ŠÖ”
        val d2 = Math.sinh(x)
        // •W€ŠÖ”‚Æ‚Ì·ˆÙ
        System.out.println("%3d : %17.10f - %17.10f = %13.10f".format(x, d1, d2, d1 - d2));
    }
