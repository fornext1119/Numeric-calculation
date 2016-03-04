import java.lang.*;

public class Java1103 {

    private static final int N = 4;

	// LR分解で固有値を求める
    public static void main(String []args) {
        double[][] a = {{5.0, 4.0, 1.0, 1.0}, 
                        {4.0, 5.0, 1.0, 1.0}, 
                        {1.0, 1.0, 4.0, 2.0},
                        {1.0, 1.0, 2.0, 4.0}};
		double[][] l = new double[N][N];
		double[][] u = new double[N][N];

        for (int k = 1; k <= 200; k++) {
		    // LU分解
		    decomp(a, l, u);
	        // 行列の積
	        multiply(u, l, a);
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
        System.out.println("eigenvalue");
        disp_eigenvalue(a);
    }

	// LU分解
    private static void decomp(double[][] a, double[][] l, double[][] u) {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
	            l[i][j] = 0.0;
	            u[i][j] = 0.0;
			}
		}
		
	    l[0][0] = 1.0;
        for (int j = 0; j < N; j++)
	        u[0][j] = a[0][j];

        for (int i = 1; i < N; i++) {
	        u[i][0] = 0.0;
	        l[0][i] = 0.0;
	        l[i][0] = a[i][0] / u[0][0];
	    }
        for (int i = 1; i < N; i++) {
	        l[i][i] = 1.0;
	        double t = a[i][i];
	        for (int k = 0; k <= i; k++)
	            t -= l[i][k] * u[k][i];
	        u[i][i] = t;
	        for (int j = i + 1; j < N; j++) {
	            u[j][i] = 0.0;
                l[i][j] = 0.0;
	            t       = a[j][i];
		        for (int k = 0; k <= i; k++)
	                t -= l[j][k] * u[k][i];
	            l[j][i] = t / u[i][i];
	            t       = a[i][j];
		        for (int k = 0; k <= i; k++)
	                t -= l[i][k] * u[k][j];
	            u[i][j] = t;
	        }
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
