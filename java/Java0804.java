import static java.lang.System.out;

public class Java0804 {

    // �d�͉����x
	private static final double g = -9.8;
	// ��C��R�W��
	private static final double k = -0.01;
	// ���ԊԊu(�b)
	private static final double h = 0.01;

    public static void main(String []args) {
	    // �p�x
	    double degree = 45;
	    double radian = degree * Math.PI / 180.0;
	    // ���� 250 km/h -> �b���ɕϊ�
	    double v = 250 * 1000 / 3600;
	    // ���������̑��x
        double[] vx = new double[5];
	    vx[0] = v * Math.cos(radian); 
	    // ���������̑��x
        double[] vy = new double[5];
	    vy[0] = v * Math.sin(radian); 
	    // �o�ߕb��
	    double t = 0.0;
	    // �ʒu
        double[] x = new double[5];
    	x[0] = 0.0;
        double[] y = new double[5];
    	y[0] = 0.0;

    	// Runge-Kutta�@
	    for (int i = 1; y[0] >= 0.0; i++) {
	        // �o�ߕb��
	        t = i * h;

	        // �ʒu�E���x
	        x[1]  = h *    vx[0];
	        y[1]  = h *    vy[0];
	        vx[1] = h * fx(vx[0], vy[0]);
	        vy[1] = h * fy(vx[0], vy[0]);

	        double wx = vx[0] + vx[1] / 2;
	        double wy = vy[0] + vy[1] / 2;
	        x[2]  = h *    wx;
	        y[2]  = h *    wy;
	        vx[2] = h * fx(wx, wy);
	        vy[2] = h * fy(wx, wy);

	        wx    = vx[0] + vx[2] / 2;
	        wy    = vy[0] + vy[2] / 2;
	        x[3]  = h *    wx;
	        y[3]  = h *    wy;
	        vx[3] = h * fx(wx, wy);
	        vy[3] = h * fy(wx, wy);

	        wx    = vx[0] + vx[3];
	        wy    = vy[0] + vy[3];
	        x[4]  = h *    wx;
	        y[4]  = h *    wy;
	        vx[4] = h * fx(wx, wy);
	        vy[4] = h * fy(wx, wy);

	        x[0]  += ( x[1] +  x[2] * 2 +  x[3] * 2 +  x[4]) / 6;
	        y[0]  += ( y[1] +  y[2] * 2 +  y[3] * 2 +  y[4]) / 6;
	        vx[0] += (vx[1] + vx[2] * 2 + vx[3] * 2 + vx[4]) / 6;
	        vy[0] += (vy[1] + vy[2] * 2 + vy[3] * 2 + vy[4]) / 6;

            out.println(String.format("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f", t, vx[0], vy[0], x[0], y[0]));
	    }
	}

	// ��C��R�ɂ�鐅�������̌�����
	private static double fx(double vx, double vy) {
	    return k * Math.sqrt(vx * vx + vy * vy) * vx;
	}
	// �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
	private static double fy(double vx, double vy) {
	    return g + (k * Math.sqrt(vx * vx + vy * vy) * vy);
	}
}
