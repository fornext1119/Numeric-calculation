import static java.lang.System.out;

public class Java0801 {

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
        double[] vx = new double[2];
	    vx[0] = v * Math.cos(radian); 
	    // ���������̑��x
        double[] vy = new double[2];
	    vy[0] = v * Math.sin(radian); 
	    // �o�ߕb��
	    double t = 0.0;
	    // �ʒu
	    double x = 0.0;
	    double y = 0.0;

	    // Euler�@
	    for (int i = 1; y >= 0.0; i++) {
	        // �o�ߕb��
	        t = i * h;

	        // �ʒu
	        x += h * vx[0];
	        y += h * vy[0];
            out.println(String.format("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f", t, vx[0], vy[0], x, y));

	        // ���x
	        vx[1] = vx[0] + h * fx(vx[0], vy[0]);
	        vy[1] = vy[0] + h * fy(vx[0], vy[0]);
	        vx[0] = vx[1];
	        vy[0] = vy[1];
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
