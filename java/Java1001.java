import java.lang.*;

public class Java1001 {

    private static final int N = 4; 

    public static void main(String []args) {
        double[][] a = {{9,2,1,1},{2,8,-2,1},{-1,-2,7,-2},{1,-1,-2,6}}; 
        double[]   b = {20,16,8,17};
        double[]   c = {0,0,0,0};

        // ���R�r�̔����@
        jacobi(a,b,c);

        System.out.println("X");
        disp_vector(c);
    }

    // ���R�r�̔����@
    private static void jacobi(double[][] a, double[] b, double[] x0) {
        while (true) {
            double[] x1 = new double[N];
            boolean finish = true;
            for (int i = 0; i < N; i++) {
                x1[i] = 0;
                for (int j = 0; j < N; j++)
                    if (j != i)
                        x1[i] += a[i][j] * x0[j];

                x1[i] = (b[i] - x1[i]) / a[i][i];
                if (Math.abs(x1[i] - x0[i]) > 0.0000000001) finish = false;
            }
            for (int i = 0; i < N; i++)
                x0[i] = x1[i];
            if (finish) return;

            disp_vector(x0);
        }
    }
	// �P�����z���\��
	private static void disp_vector(double[] row) {
        for (double col: row)
            System.out.print(String.format("%14.10f\t", col));
        System.out.println();
	}
}
