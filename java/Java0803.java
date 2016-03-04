import static java.lang.System.out;

public class Java0803 {

    // 重力加速度
	private static final double g = -9.8;
	// 空気抵抗係数
	private static final double k = -0.01;
	// 時間間隔(秒)
	private static final double h = 0.01;

    public static void main(String []args) {
	    // 角度
	    double degree = 45;
	    double radian = degree * Math.PI / 180.0;
	    // 初速 250 km/h -> 秒速に変換
	    double v = 250 * 1000 / 3600;
	    // 水平方向の速度
        double[] vx = new double[2];
	    vx[0] = v * Math.cos(radian); 
	    // 鉛直方向の速度
        double[] vy = new double[2];
	    vy[0] = v * Math.sin(radian); 
	    // 経過秒数
	    double t = 0.0;
	    // 位置
        double[] x = new double[2];
    	x[0] = 0.0;
        double[] y = new double[2];
    	y[0] = 0.0;

    	// 中点法
	    for (int i = 1; y[0] >= 0.0; i++) {
	        // 経過秒数
	        t = i * h;

	        // 位置・速度
	        vx[1] = h * fx(vx[0], vy[0]);
	        vy[1] = h * fy(vx[0], vy[0]);
	        
	        double wx = vx[0] + vx[1] / 2;
	        double wy = vy[0] + vy[1] / 2;
	        vx[0]     = vx[0] + h * fx(wx, wy);
	        vy[0]     = vy[0] + h * fy(wx, wy);
	        x[0]      =  x[0] + h *    wx;
	        y[0]      =  y[0] + h *    wy;

            out.println(String.format("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f", t, vx[0], vy[0], x[0], y[0]));
	    }
	}

	// 空気抵抗による水平方向の減速分
	private static double fx(double vx, double vy) {
	    return k * Math.sqrt(vx * vx + vy * vy) * vx;
	}
	// 重力と空気抵抗による鉛直方向の減速分
	private static double fy(double vx, double vy) {
	    return g + (k * Math.sqrt(vx * vx + vy * vy) * vy);
	}
}
