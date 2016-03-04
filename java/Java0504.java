public class Java0504 {
    public static void main(String []args) {
        for (int i = -10; i <= 10; i++) {
            double x  = i / 4.0;
            // �W���̎w���֐�
            double d1 = Math.exp(x);
            // ����̎w���֐�
            double d2 = myExp(x, 1, 1.0, 1.0, 1.0);
            // �W���֐��Ƃ̍���
            System.out.println(String.format("%5.2f : %13.10f - %13.10f = %13.10f", x, d1, d2, d1 - d2));
        }
    }

    // ����̎w���֐�
    private static double myExp(double x, int n, double numerator, double denominator, double y) {
        denominator = denominator * n;
        numerator   = numerator   * x;
        double a    = numerator / denominator;
        // �\���Ȑ��x�ɂȂ����珈���𔲂���
        if (Math.abs(a) <= 0.00000000001)
            return y;
        else
            return y + myExp(x, ++n, numerator, denominator, a);
    }
}
