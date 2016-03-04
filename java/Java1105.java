import java.lang.*;

public class Java1105 {

    private static final int N = 4;

	// ���R�r�@�ŌŗL�l�����߂�
    public static void main(String []args) {
        double[][] a = {{5.0, 4.0, 1.0, 1.0}, 
                        {4.0, 5.0, 1.0, 1.0}, 
                        {1.0, 1.0, 4.0, 2.0},
                        {1.0, 1.0, 2.0, 4.0}};
        double[][] v = {{1.0, 0.0, 0.0, 0.0}, 
                        {0.0, 1.0, 0.0, 0.0}, 
                        {0.0, 0.0, 1.0, 0.0},
                        {0.0, 0.0, 0.0, 1.0}};

        // ���R�r�@
        jacobi(a, v);

        System.out.println();
        System.out.println("eigenvalue");
		disp_eigenvalue(a);

        System.out.println();
        System.out.println("eigenvector");
		disp_eigenvector(v);
    }

    // ���R�r�@
    private static void jacobi(double[][] a, double[][] v) {
        for (int k = 1; k <= 100; k++) {
	        // �ő�l��T��
			int p = 0;
			int q = 0;
	        double max_val = 0.0;
            for (int i = 0; i < N; i++) {
                for (int j = i + 1; j < N; j++) {
	                if (max_val < Math.abs(a[i][j])) {
	                    max_val = Math.abs(a[i][j]);
	                    p = i;
	                    q = j;
					}
				}
			}

	        // �� �����߂�
	        double t = 0.0;
	        if (Math.abs(a[p][p] - a[q][q]) < 0.00000000001) {
	            // a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
	            t = Math.PI / 4.0;
	            if (a[p][p] < 0)
	                t = -t;
	        }
	        else {
	            // a_{pp} �� a_{qq} �̂Ƃ�
	            t = Math.atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0;
	        }

	        // �� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
	        double c = Math.cos(t);
	        double s = Math.sin(t);
	        // U^t �~ A
	        double t1 = 0.0;
	        double t2 = 0.0;
            for (int i = 0; i < N; i++) {
	            t1      =  a[p][i] * c + a[q][i] * s;
	            t2      = -a[p][i] * s + a[q][i] * c;
	            a[p][i] = t1;
	            a[q][i] = t2;
	            // �ŗL�x�N�g��
	            t1      =  v[p][i] * c + v[q][i] * s;
	            t2      = -v[p][i] * s + v[q][i] * c;
	            v[p][i] = t1;
	            v[q][i] = t2;
	        }
	        // A �~ U
            for (int i = 0; i < N; i++) {
	            t1      =  a[i][p] * c + a[i][q] * s;
	            t2      = -a[i][p] * s + a[i][q] * c;
	            a[i][p] = t1;
	            a[i][q] = t2;
	        }

	        // �Ίp�v�f��\��
        	System.out.print(String.format("%3d\t", k));
	        disp_eigenvalue(a);

	        // ��������
        	if (max_val < 0.00000000001) break;
	    }
	}

    // �Ίp�v�f��\��
    private static void disp_eigenvalue(double[][] a) {
        for (int i = 0; i < N; i++)
            System.out.print(String.format("%14.10f\t", a[i][i]));
        System.out.println();
    }
    // �ŗL�x�N�g����\��
    private static void disp_eigenvector(double[][] matrix) {
        for (int i = 0; i < N; i++) {
			double[] row = new double[N];
            for (int j = 0; j < N; j++)
                row[j] = matrix[i][j] ;
	        normarize(row);
	        disp_vector(row);
		}
    }
    // �P�����z���\��
    private static void disp_vector(double[] row) {
        for (double col: row)
            System.out.print(String.format("%14.10f\t", col));
        System.out.println();
    }
	// ���K�� (�x�N�g���̒������P�ɂ���)
    private static void normarize(double[] x) {
        double s = 0.0;

        for (int i = 0; i < N; i++)
	        s += x[i] * x[i];
	    s = Math.sqrt(s);
	    
        for (int i = 0; i < N; i++)
	        x[i] /= s;
	}
}
