public class Java0704 {

	// データ点の数
    private static final int N   =  7; 
    private static final int Nx2 = 14; 

    public static void main(String []args) {
        double[] x  = new double[N];
        double[] y  = new double[N];
        double[] yd = new double[N];

	    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
	    for (int i = 0; i < N; i++) {
	        double d1 = i * 1.5 - 4.5;
            x[i]  = d1;
            y[i]  = f(d1);
            yd[i] = fd(d1);
        }

	    // 差分商の表を作る
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

	    // ｎ階差分商
        double[] a = new double[Nx2];
	    for (int j = 0; j < Nx2; j++)
	        a[j] = d[j][0];

	    // 0.5刻みで 与えられていない値を補間
	    for (int i = 0; i <= 18; i++) {
	        double d1 = i * 0.5 - 4.5;
            double d2 = f(d1);
            double d3 = hermite(d1, z, a);

            // 元の関数と比較
            System.out.println(String.format("%5.2f\t%8.5f\t%8.5f\t%8.5f", d1, d2, d3, d2 - d3));
        }
    }

    // 元の関数
    private static double f(double x) {
	    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2);
    }
	// 導関数
	private static double fd(double x) {
	    return 1 - Math.pow(x,2) / 2 + Math.pow(x,4) / (4 * 3 * 2); 
	}

	// Hermite (エルミート) 補間
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
