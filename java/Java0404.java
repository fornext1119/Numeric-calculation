public class Java0404 {
    // ���~�K��p
    private static int FallingFact(int x, int n) {
        if (n <= 1)
            return x;
        else
            return x * FallingFact(x - 1, n - 1);
    }

     public static void main(String []args) {
        // 10 ���� 6 �܂ł� ����
        System.out.println(FallingFact(10, 5));
        System.out.println(10 * 9 * 8 * 7 * 6);
    }
}
