public class Java0506 {
    public static void main(String []args) {
        for (int i = 1; i <= 20; i++) {
            double x  = i / 5.0;
            // �W���̑ΐ��֐�
            double d1 = Math.log(x);
            // ����̑ΐ��֐�
            double x2 = (x - 1) / (x + 1);  
            double d2 = 2 * myLog(x2, x2, 1.0, x2);
            // �W���֐��Ƃ̍���
            System.out.println(String.format("%5.2f : %13.10f - %13.10f = %13.10f", x, d1, d2, d1 - d2));
        }
    }

    // ����̑ΐ��֐�
    private static double myLog(double x2, double numerator, double denominator, double y) {
        denominator = denominator + 2;
        numerator   = numerator   * x2 * x2;
        double a    = numerator / denominator;
        // �\���Ȑ��x�ɂȂ����珈���𔲂���
        if (Math.abs(a) <= 0.00000000001)
            return y;
        else
            return y + myLog(x2, numerator, denominator, a);
    }
}
