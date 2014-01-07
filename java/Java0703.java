public class Java0703 {

	// データ点の数
    private static final int N = 7; 

    public static void main(String []args) {
        double[] x = new double[N];
        double[] y = new double[N];

	    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
	    for (int i = 0; i < N; i++) {
	        double d1 = i * 1.5 - 4.5;
            x[i] = d1;
            y[i] = f(d1);
        }

	    // 差分商の表を作る
        double[][] d = new double[N][N];
	    for (int j = 0; j < N; j++)
	        d[0][j] = y[j];

	    for (int i = 1; i < N; i++) {
	        for (int j = 0; j < N - i; j++)
	            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j]);
	    }

	    // ｎ階差分商
        double[] a = new double[N];
	    for (int j = 0; j < N; j++)
	        a[j] = d[j][0];

	    // 0.5刻みで 与えられていない値を補間
	    for (int i = 0; i <= 18; i++) {
	        double d1 = i * 0.5 - 4.5;
            double d2 = f(d1);
            double d3 = newton(d1, x, a);

            // 元の関数と比較
            System.out.println(String.format("%5.2f\t%8.5f\t%8.5f\t%8.5f", d1, d2, d3, d2 - d3));
        }
    }

    // 元の関数
    private static double f(double x) {
	    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2);
    }

	// Newton (ニュートン) 補間
    private static double newton(double d, double[] x, double[] a) {
	    double sum = a[0];
	    for (int i = 1; i < N; i++) {
	        double prod = a[i];
	        for (int j = 0; j < i; j++)
	            prod *= (d - x[j]);
	        sum += prod;
	    }

	    return sum;
    }
}
