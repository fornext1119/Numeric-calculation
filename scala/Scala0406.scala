// �K��
def Fact(n: Int): Int = {
    n match {
        case 0 => 1
        case _ => n * Fact(n - 1)
    }
}
// ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
val n = 10
val r = 5
Fact(n) / Fact(n - r)
// ���~�K��p
def FallingFact(x: Int, n: Int): Int = {
    n match {
        case 1 => x
        case _ => x * FallingFact(x - 1, n - 1)
    }
}
// ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
val n = 10
val r = 5
FallingFact(n, r)
