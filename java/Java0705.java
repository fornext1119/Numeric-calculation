public class Java0705 {

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

	    // �R���������̌W���̕\�����
        double[] a = new double[N];
        double[] b = new double[N];
        double[] c = new double[N];
        double[] d = new double[N];
	    for (int i = 1; i < N - 1; i++) {
	        a[i] =         x[i]   - x[i-1]; 
	        b[i] = 2.0 *  (x[i+1] - x[i-1]); 
	        c[i] =         x[i+1] - x[i]; 
	        d[i] = 6.0 * ((y[i+1] - y[i]) / (x[i+1] - x[i]) - (y[i] - y[i-1]) / (x[i] - x[i-1]));
	    }
	    // �R�������������� (�g�|�}�X�@)
        double[] g = new double[N];
        double[] s = new double[N];
	    g[1] = b[1];
	    s[1] = d[1];
	    for (int i = 2; i < N - 1; i++) {
	        g[i] = b[i] - a[i] * c[i-1] / g[i-1];
	        s[i] = d[i] - a[i] * s[i-1] / g[i-1];
	    }
        double[] z = new double[N];
	    z[0]   = 0;
	    z[N-1] = 0;
	    z[N-2] = s[N-2] / g[N-2];
	    for (int i = N - 3; i >= 1; i--)
	        z[i] = (s[i] - c[i] * z[i+1]) / g[i];

	    // 0.5���݂� �^�����Ă��Ȃ��l����
	    for (int i = 0; i <= 18; i++) {
	        double d1 = i * 0.5 - 4.5;
            double d2 = f(d1);
            double d3 = spline(d1, x, y, z);

            // ���̊֐��Ɣ�r
            System.out.println(String.format("%5.2f\t%8.5f\t%8.5f\t%8.5f", d1, d2, d3, d2 - d3));
        }
    }

    // ���̊֐�
    private static double f(double x) {
	    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2);
    }

	// Spline (�X�v���C��) ���
	private static double spline(double d, double[] x, double[] y, double[] z) {
	    // ��Ԋ֐��l���ǂ̋�Ԃɂ��邩
	    int k = -1;
	    for (int i = 1; i < N; i++) {
	        if (d <= x[i]) {
	            k = i - 1;
	            break;
	        }
	    }
        if (k < 0) k = N - 1;

	    double d1 = x[k+1] - d;
	    double d2 = d      - x[k];
	    double d3 = x[k+1] - x[k];
	    return      (z[k] * Math.pow(d1,3) + z[k+1] * Math.pow(d2,3)) / (6.0 * d3)
	              + (y[k]   / d3 - z[k]   * d3 / 6.0) * d1  
	              + (y[k+1] / d3 - z[k+1] * d3 / 6.0) * d2;
    }
}
