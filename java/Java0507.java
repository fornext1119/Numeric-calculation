public class Java0507 {
    public static void main(String []args) {
        for (int i = 1; i <= 20; i++) {
            double x  = i / 5.0;
            // �W���̑ΐ��֐�
            double d1 = Math.log(x);
            // ����̑ΐ��֐�
            double d2 = myLog(x - 1, 27, 0.0); // 27:�K�v�Ȑ��x��������\���傫�Ȋ
            // �W���֐��Ƃ̍���
            System.out.println(String.format("%5.2f : %13.10f - %13.10f = %13.10f", x, d1, d2, d1 - d2));
        }
    }

    // ����̑ΐ��֐�
    private static double myLog(double x, int n, double t) {
        int    n2 = n;
        double x2 = x;
        if (n > 3) {
            if (n % 2 == 0)
                n2 = 2;
            x2 = x * (n / 2);
        }
        t = x2 / (n2 + t);

        if (n <= 2)
            return x / (1 + t);
        else
            return myLog(x, --n, t);
    }
}
