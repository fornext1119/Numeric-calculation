import java.lang.*;

public class Java1101 {

    private static final int N = 4;

    // ベキ乗法で最大固有値を求める
    public static void main(String []args) {
        double[][] a = {{5.0, 4.0, 1.0, 1.0}, 
                        {4.0, 5.0, 1.0, 1.0}, 
                        {1.0, 1.0, 4.0, 2.0},
                        {1.0, 1.0, 2.0, 4.0}};
        double[]   x  = {1.0 ,0.0 ,0.0 ,0.0};

        // ベキ乗法
        double lambda = power(a, x);

        System.out.println();
        System.out.println("eigenvalue");
        System.out.println(String.format("%14.10f", lambda));

        System.out.println("eigenvector");
        disp_vector(x);
    }

    // ベキ乗法
    private static double power(double[][] a, double[] x0) {
        double lambda = 0.0;

        // 正規化 (ベクトル x0 の長さを１にする)
        normarize(x0);
        double e0 = 0.0;
        for (int i = 0; i < N; i++)
            e0 += x0[i];

        for (int k = 1; k <= 100; k++) {
            // １次元配列を表示
            System.out.print(String.format("%3d\t", k));
            disp_vector(x0);

            // 行列の積 x1 = A × x0 
            double[] x1 = new double[N];
            for (int i = 0; i < N; i++)
                for (int j = 0; j < N; j++)
                    x1[i] += a[i][j] * x0[j];
            
            // 内積
            double p0 = 0.0;
            double p1 = 0.0;
            for (int i = 0; i < N; i++) {
                p0 += x1[i] * x1[i];
                p1 += x1[i] * x0[i];
            }
            // 固有値
            lambda = p0 / p1;

            // 正規化 (ベクトル x1 の長さを１にする)
            normarize(x1);
            // 収束判定
            double e1 = 0.0;
            for (int i = 0; i < N; i++)
                e1 += x1[i];
            if (Math.abs(e0 - e1) < 0.00000000001) break;

            for (int i = 0; i < N; i++)
                x0[i] = x1[i];
            e0 = e1;
        }
        return lambda;
    }

    // １次元配列を表示
    private static void disp_vector(double[] row) {
        for (double col: row)
            System.out.print(String.format("%14.10f\t", col));
        System.out.println();
    }
    // 正規化 (ベクトルの長さを１にする)
    private static void normarize(double[] x) {
        double s = 0.0;

        for (int i = 0; i < N; i++)
            s += x[i] * x[i];
        s = Math.sqrt(s);
        
        for (int i = 0; i < N; i++)
            x[i] /= s;
    }
}
