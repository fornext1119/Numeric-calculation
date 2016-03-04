import java.lang.*;

public class Java1104 {

    private static final int N = 4;

	// QR分解で固有値を求める
    public static void main(String []args) {
        double[][] a = {{5.0, 4.0, 1.0, 1.0}, 
                        {4.0, 5.0, 1.0, 1.0}, 
                        {1.0, 1.0, 4.0, 2.0},
                        {1.0, 1.0, 2.0, 4.0}};
		double[][] q = new double[N][N];
		double[][] r = new double[N][N];

        for (int k = 1; k <= 200; k++) {
		    // QR分解
		    decomp(a, q, r);
	        // 行列の積
	        multiply(r, q, a);
	        // 対角要素を表示
        	System.out.print(String.format("%3d\t", k));
	        disp_eigenvalue(a);
	        
	        // 収束判定
        	double e = 0.0;
            for (int i = 1; i < N; i++)
                for (int j = 0; j < i; j++)
                    e += Math.abs(a[i][j]);
	        if (e < 0.00000000001) break;
		}

        System.out.println();
        System.out.println("固有値");
        disp_eigenvalue(a);
    }

	// QR分解
    private static void decomp(double[][] a, double[][] q, double[][] r) {
		double[] x = new double[N];

        for (int k = 0; k < N; k++) {
	        for (int i = 0; i < N; i++)
	            x[i] = a[i][k];

            for (int j = 0; j < k; j++) {
				double t = 0.0;
		        for (int i = 0; i < N; i++)
	                t += a[i][k] * q[i][j];
	            r[j][k] = t;
	            r[k][j] = 0.0;
		        for (int i = 0; i < N; i++)
            		x[i] -= t * q[i][j];
			}

			double s = 0.0;
	        for (int i = 0; i < N; i++)
                s += x[i] * x[i];
			r[k][k] = Math.sqrt(s);
	        for (int i = 0; i < N; i++)
	            q[i][k] = x[i] / r[k][k];
	    }
    }
	// 行列の積
    private static void multiply(double[][] a, double[][] b, double[][] c) {
        for (int i = 0; i < N; i++) {
	        for (int j = 0; j < N; j++) {
				double s = 0.0;
		        for (int k = 0; k < N; k++)
	                s += a[i][k] * b[k][j];
	            c[i][j] = s;
	        }
        }
    }

    // 対角要素を表示
    private static void disp_eigenvalue(double[][] a) {
        for (int i = 0; i < N; i++)
            System.out.print(String.format("%14.10f\t", a[i][i]));
        System.out.println();
    }
}
