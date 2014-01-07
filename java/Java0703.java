public class Java0703 {

	// �f�[�^�_�̐�
    private static final int N = 7; 

    public static void main(String []args) {
        double[] x = new double[N];
        double[] y = new double[N];

	    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
	    for (int i = 0; i < N; i++) {
	        double d1 = i * 1.5 - 4.5;
            x[i] = d1;
            y[i] = f(d1);
        }

	    // �������̕\�����
        double[][] d = new double[N][N];
	    for (int j = 0; j < N; j++)
	        d[0][j] = y[j];

	    for (int i = 1; i < N; i++) {
	        for (int j = 0; j < N - i; j++)
	            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j]);
	    }

	    // ���K������
        double[] a = new double[N];
	    for (int j = 0; j < N; j++)
	        a[j] = d[j][0];

	    // 0.5���݂� �^�����Ă��Ȃ��l����
	    for (int i = 0; i <= 18; i++) {
	        double d1 = i * 0.5 - 4.5;
            double d2 = f(d1);
            double d3 = newton(d1, x, a);

            // ���̊֐��Ɣ�r
            System.out.println(String.format("%5.2f\t%8.5f\t%8.5f\t%8.5f", d1, d2, d3, d2 - d3));
        }
    }

    // ���̊֐�
    private static double f(double x) {
	    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2);
    }

	// Newton (�j���[�g��) ���
    private static double newton(double d, double[] x, double[] a) {
	    double sum = a[0];
	    for (int i = 1; i < N; i++) {
	        double prod = a[i];
	        for (int j = 0; j < i; j++)
	            prod *= (d - x[j]);
	        sum += prod;
	    }

	    return sum;
    }
}
