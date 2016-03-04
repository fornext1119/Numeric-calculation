import java.lang.*;

public class Java1005 {

    private static final int N = 4; 

    // LU����
    public static void main(String []args) {
	    double[][] a = {{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}}; 
	    double[]   b = {8,17,20,16};

	    // �s�{�b�g�I��
	    pivoting(a,b);

	    System.out.println("pivoting");
	    System.out.println("A");
    	disp_matrix(a);
	    System.out.println("B");
	    disp_vector(b);
	    System.out.println();

	    // �O�i����
	    forward_elimination(a,b);

	    System.out.println("LU");
    	disp_matrix(a);

	    // Ly=b ���� y �����߂� (�O�i���)
	    double y[] = {0,0,0,0};
	    forward_substitution(a,b,y);

	    System.out.println("Y");
	    disp_vector(y);

	    // Ux=y ���� x �����߂� (��ޑ��)
	    double x[] = {0,0,0,0};
	    backward_substitution(a,y,x);

	    System.out.println("X");
	    disp_vector(x);
	}
	// �O�i����
	private static void forward_elimination(double[][] a, double[] b) {
	    for (int pivot = 0; pivot < N - 1; pivot++) {
	        for (int row = pivot + 1; row < N; row++) {
	            double s = a[row][pivot] / a[pivot][pivot];
	            for (int col = pivot; col < N; col++)
	                a[row][col] -= a[pivot][col] * s; // ���ꂪ ��O�p�s��
	            a[row][pivot] = s;                    // ���ꂪ ���O�p�s��
	            // b[row]    -= b[pivot] * s;         // ���̒l�͕ύX���Ȃ�
	        }
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
	            y[row] -= a[row][col] * x[col];
	        x[row] = y[row] / a[row][row];
	    }
	}
	// �s�{�b�g�I��
	private static void pivoting(double[][] a, double[] b) {
	    for(int pivot = 0; pivot < N; pivot++) {
	        // �e��� ��Ԓl���傫���s�� �T��
	        int     max_row =   pivot;
	        double  max_val =   0;
	        for (int row = pivot; row < N; row++) {
	            if (Math.abs(a[row][pivot]) > max_val) {
	                // ��Ԓl���傫���s
	                max_val =   Math.abs(a[row][pivot]);
	                max_row =   row;
	            }
	        }

	        // ��Ԓl���傫���s�Ɠ���ւ�
	        if (max_row != pivot) {
	            double tmp;
	            for (int col = 0; col < N; col++) {
	                tmp             =   a[max_row][col];
	                a[max_row][col] =   a[pivot][col];
	                a[pivot][col]   =   tmp;
	            }
	            tmp         =   b[max_row];
	            b[max_row]  =   b[pivot];
	            b[pivot]    =   tmp;
	        }
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
