// â∫ç~äKèÊôp
def FallingFact(x: Int, n: Int): Int = {
    n match {
        case 1 => x
        case _ => x * FallingFact(x - 1, n - 1)
    }
}
// 10 Ç©ÇÁ 6 Ç‹Ç≈ÇÃ ëçèÊ
FallingFact(10, 5)
