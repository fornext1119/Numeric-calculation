public class Java0402 {
    public static void main(String []args) {
        // ���� 5, ���� 3, ���� 10 �̐���̐ς�\������
        System.out.println(product(5, 3, 10));
    }
    private static long product(int m, int d, int n) {
        if (n == 0)
            return 1;
        else
            return m * product(m + d, d, n - 1);
    }
}
