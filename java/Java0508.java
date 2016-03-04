public class Java0508 {
    public static void main(String []args) {
        for (int x = -10; x <= 10; x++) {
            // ����̑o�Ȑ������֐�
            double d1 = mySinh(x, 1, x, 1.0, x);
            // �W���̑o�Ȑ������֐�
            double d2 = Math.sinh(x);
            // �W���֐��Ƃ̍���
            System.out.println(String.format("%3d : %17.10f - %17.10f = %13.10f", x, d1, d2, d1 - d2));
        }
    }

    // ����̑o�Ȑ������֐�
    private static double mySinh(double x, int n, double numerator, double denominator, double y) {
        int m       = 2 * n;
        denominator = denominator * (m + 1) * m;
        numerator   = numerator   * x * x;
        double a    = numerator / denominator;
        // �\���Ȑ��x�ɂȂ����珈���𔲂���
        if (Math.abs(a) <= 0.00000000001) 
            return y;
        else
            return y + mySinh(x, ++n, numerator, denominator, a);
    }
}
