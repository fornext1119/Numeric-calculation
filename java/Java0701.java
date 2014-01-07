public class Java0701 {

	// �f�[�^�_�̐�
    private static final int N = 7; 

    public static void main(String []args) {
        double[] x = new double[N];
        double[] y = new double[N];

	    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
	    for (int i = 0; i < N; i++) {
	        double d = i * 1.5 - 4.5;
            x[i] = d;
            y[i] = f(d);
        }

	    // 0.5���݂� �^�����Ă��Ȃ��l����
	    for (int i = 0; i <= 18; i++) {
	        double d  = i * 0.5 - 4.5;
            double d1 = f(d);
            double d2 = lagrange(d, x, y);

            // ���̊֐��Ɣ�r
            System.out.println(String.format("%5.2f\t%8.5f\t%8.5f\t%8.5f", d, d1, d2, d1 - d2));
        }
    }

    // ���̊֐�
    private static double f(double x) {
	    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2);
    }

    // Lagrange (���O�����W��) ���
    private static double lagrange(double d, double[] x, double[] y) {
        double sum = 0;
        for (int i = 0; i < N; i++) {
            double prod = y[i];
            for (int j = 0; j < N; j++) {
                if (j != i)
                    prod *= (d - x[j]) / (x[i] - x[j]);
            }
            sum += prod;
        }
        return sum;
    }
}
