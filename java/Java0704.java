public class Java0704 {

	// �f�[�^�_�̐�
    private static final int N   =  7; 
    private static final int Nx2 = 14; 

    public static void main(String []args) {
        double[] x  = new double[N];
        double[] y  = new double[N];
        double[] yd = new double[N];

	    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
	    for (int i = 0; i < N; i++) {
	        double d1 = i * 1.5 - 4.5;
            x[i]  = d1;
            y[i]  = f(d1);
            yd[i] = fd(d1);
        }

	    // �������̕\�����
        double[]  z = new double[Nx2];
        double[][] d = new double[Nx2][Nx2];
	    for (int i = 0; i < Nx2; i++) {
	        int j   = i / 2;
	        z[i]    = x[j];
	        d[0][i] = y[j];
		}
	    for (int i = 1; i < Nx2; i++) {
	        for (int j = 0; j < Nx2 - i; j++)
	        {
	            if (i == 1 && j % 2 == 0)
	                d[i][j] = yd[j / 2];
	            else
		            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (z[j+i] - z[j]);
		    }
	    }

	    // ���K������
        double[] a = new double[Nx2];
	    for (int j = 0; j < Nx2; j++)
	        a[j] = d[j][0];

	    // 0.5���݂� �^�����Ă��Ȃ��l����
	    for (int i = 0; i <= 18; i++) {
	        double d1 = i * 0.5 - 4.5;
            double d2 = f(d1);
            double d3 = hermite(d1, z, a);

            // ���̊֐��Ɣ�r
            System.out.println(String.format("%5.2f\t%8.5f\t%8.5f\t%8.5f", d1, d2, d3, d2 - d3));
        }
    }

    // ���̊֐�
    private static double f(double x) {
	    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2);
    }
	// ���֐�
	private static double fd(double x) {
	    return 1 - Math.pow(x,2) / 2 + Math.pow(x,4) / (4 * 3 * 2); 
	}

	// Hermite (�G���~�[�g) ���
    private static double hermite(double d, double[] z, double[] a) {
	    double sum = a[0];
	    for (int i = 1; i < Nx2; i++) {
	        double prod = a[i];
	        for (int j = 0; j < i; j++)
	            prod *= (d - z[j]);
	        sum += prod;
	    }

	    return sum;
    }
}
