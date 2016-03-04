public class Java1006 {

    private static final int N = 4; 

	// コレスキー法
    public static void main(String []args) {
	    double[][] a = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}; 
	    double[]   b = {34,68,96,125};

	    System.out.println("A");
    	disp_matrix(a);
	    System.out.println("B");
	    disp_vector(b);
	    System.out.println();

	    // 前進消去
	    forward_elimination(a,b);

	    System.out.println("LL^T");
    	disp_matrix(a);

	    // Ly=b から y を求める (前進代入)
	    double y[] = {0,0,0,0};
	    forward_substitution(a,b,y);

	    System.out.println("Y");
	    disp_vector(y);

	    // L^Tx=y から x を求める (後退代入)
	    double x[] = {0,0,0,0};
	    backward_substitution(a,y,x);

	    System.out.println("X");
	    disp_vector(x);
	}
	// 前進消去
	private static void forward_elimination(double[][] a, double[] b) {
	    for (int pivot = 0; pivot < N; pivot++) {
	        double s = 0;
	        for (int col = 0; col < pivot; col++)
	            s += a[pivot][col] * a[pivot][col];
	        // ここで根号の中が負の値になると計算できない！
	        a[pivot][pivot] = Math.sqrt(a[pivot][pivot] - s);

	        for (int row = pivot + 1; row < N; row++) {
	            s = 0;
	            for (int col = 0; col < pivot; col++)
	                s += a[row][col] * a[pivot][col];
	            a[row][pivot] =  (a[row][pivot] - s) / a[pivot][pivot];
	            a[pivot][row] =  a[row][pivot];
	        } 
	    }
	}
    // 前進代入
	private static void forward_substitution(double[][] a, double[] b, double[] y) {
	    for (int row = 0; row < N; row++) {
	        for (int col = 0; col < row; col++)
	            b[row] -= a[row][col] * y[col];
	        y[row] = b[row] / a[row][row];
	    }
	}
    // 後退代入
	private static void backward_substitution(double[][] a, double[] y, double[] x) {
	    for (int row = N - 1; row >= 0; row--) {
	        for (int col = N - 1; col > row; col--)
	            y[row] -= a[col][row] * x[col];
	        x[row] = y[row] / a[row][row];
	    }
	}
	// １次元配列を表示
	private static void disp_vector(double[] row) {
        for (double col: row)
            System.out.print(String.format("%14.10f\t", col));
        System.out.println();
	}
	// ２次元配列を表示
	private static void disp_matrix(double[][] matrix) {
        for (double[] row: matrix) {
	        for (double col: row)
	            System.out.print(String.format("%14.10f\t", col));
	        System.out.println();
		}
	}
}
