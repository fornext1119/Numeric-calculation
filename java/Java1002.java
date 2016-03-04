import java.lang.*;

public class Java1002 {

    private static final int N = 4; 

    public static void main(String []args) {
        double[][] a = {{9,2,1,1},{2,8,-2,1},{-1,-2,7,-2},{1,-1,-2,6}}; 
	    double[]   b = {20,16,8,17};
	    double[]   c = {0,0,0,0};

		// ガウス・ザイデル法
	    gauss(a,b,c);

	    System.out.println("X");
        disp_vector(c);
	}

	// ガウス・ザイデル法
	private static void gauss(double[][] a, double[] b, double[] x0) {
	    while (true) {
	        boolean finish = true;
	        for (int i = 0; i < N; i++) {
	            double x1 = 0;
	            for (int j = 0; j < N; j++)
	                if (j != i)
	                    x1 += a[i][j] * x0[j];

	            x1 = (b[i] - x1) / a[i][i];
	            if (Math.abs(x1 - x0[i]) > 0.0000000001) finish = false;
	            x0[i] = x1;
	        }
	        if (finish) return;

            disp_vector(x0);
	    }
	}
	// １次元配列を表示
	private static void disp_vector(double[] row) {
        for (double col: row)
            System.out.print(String.format("%14.10f\t", col));
        System.out.println();
	}
}
