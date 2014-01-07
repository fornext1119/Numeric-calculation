// è„è∏äKèÊôp
def RisingFact(x: Int, n: Int): Int = {
    n match {
        case 1 => x
        case _ => x * RisingFact(x + 1, n - 1)
    }
}
// 10 Ç©ÇÁ 14 Ç‹Ç≈ÇÃ ëçèÊ
RisingFact(10, 5)
