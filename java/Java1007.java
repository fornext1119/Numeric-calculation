public class Java1007 {

    private static final int N = 4; 

	// �C���R���X�L�[�@
    public static void main(String []args) {
	    double[][] a = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}; 
	    double[]   b = {34,68,96,125};

	    System.out.println("A");
    	disp_matrix(a);
	    System.out.println("B");
	    disp_vector(b);
	    System.out.println();

	    // �O�i����
	    forward_elimination(a,b);

	    System.out.println("LDL^T");
    	disp_matrix(a);

	    // Ly=b ���� y �����߂� (�O�i���)
	    double y[] = {0,0,0,0};
	    forward_substitution(a,b,y);

	    System.out.println("Y");
	    disp_vector(y);

	    // DL^Tx=y ���� x �����߂� (��ޑ��)
	    double x[] = {0,0,0,0};
	    backward_substitution(a,y,x);

	    System.out.println("X");
	    disp_vector(x);
	}
	// �O�i����
	private static void forward_elimination(double[][] a, double[] b) {
	    for (int pivot = 0; pivot < N; pivot++) {
	        double s;

	        // pivot < k �̏ꍇ
	        for (int col = 0; col < pivot; col++) {
	            s = a[pivot][col];
	            for (int k = 0; k < col; k++)
	                s -= a[pivot][k] * a[col][k] * a[k][k];
	            a[pivot][col] = s / a[col][col];
	        }
	 
	        // pivot == k �̏ꍇ
	        s = a[pivot][pivot];
	        for (int k = 0; k < pivot; k++)
	            s -= a[pivot][k] * a[pivot][k] * a[k][k];
	        a[pivot][pivot] = s;
	    }
	}
    // �O�i���
	private static void forward_substitution(double[][] a, double[] b, double[] y) {
	    for (int row = 0; row < N; row++) {
	        for (int col = 0; col < row; col++)
	            b[row] -= a[row][col] * y[col];
	        y[row] = b[row];
	    }
	}
    // ��ޑ��
	private static void backward_substitution(double[][] a, double[] y, double[] x) {
	    for (int row = N - 1; row >= 0; row--) {
	        for (int col = N - 1; col > row; col--)
	            y[row] -= a[col][row] * a[row][row] * x[col];
	        x[row] = y[row] / a[row][row];
	    }
	}
	// �P�����z���\��
	private static void disp_vector(double[] row) {
        for (double col: row)
            System.out.print(String.format("%14.10f\t", col));
        System.out.println();
	}
	// �Q�����z���\��
	private static void disp_matrix(double[][] matrix) {
        for (double[] row: matrix) {
	        for (double col: row)
	            System.out.print(String.format("%14.10f\t", col));
	        System.out.println();
		}
	}
}
