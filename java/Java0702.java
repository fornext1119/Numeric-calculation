public class Java0702 {

    // データ点の数
    private static final int N = 7; 

    public static void main(String []args) {
        double[] x = new double[N];
        double[] y = new double[N];

	    // 1.5刻みで -4.5〜4.5 まで, ７点だけ値をセット
	    for (int i = 0; i < N; i++) {
	        double d = i * 1.5 - 4.5;
            x[i] = d;
            y[i] = f(d);
        }

	    // 0.5刻みで 与えられていない値を補間
	    for (int i = 0; i <= 18; i++) {
	        double d  = i * 0.5 - 4.5;
            double d1 = f(d);
            double d2 = neville(d, x, y);

            // 元の関数と比較
            System.out.println(String.format("%5.2f\t%8.5f\t%8.5f\t%8.5f", d, d1, d2, d1 - d2));
        }
    }

    // 元の関数
    private static double f(double x) {
	    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2);
    }

	// Neville (ネヴィル) 補間
    private static double neville(double d, double[] x, double[] y) {
        double[][] w = new double[N][N];
	    for (int i = 0; i < N; i++)
	        w[0][i] = y[i];

	    for (int j = 1; j < N; j++) {
        	for (int i = 0; i < N - j; i++)
				w[j][i] = w[j-1][i+1] + (w[j-1][i+1] - w[j-1][i]) * (d - x[i+j]) / (x[i+j] - x[i]);
	    }

	    return w[N-1][0];
    }
}
