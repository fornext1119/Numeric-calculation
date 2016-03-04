import static java.lang.System.out;

public class Java0904 {

    public static void main(String []args) {
        double x = 2;
        out.println(String.format("%12.10f", newton(x)));
    }

    private static double newton(double x0) {
        double x1;
        while (true) {
	        x1 = x0 - (f0(x0) / f1(x0));
            out.println(String.format("%12.10f\t%13.10f", x1, x1 - Math.sqrt(2)));

            if (Math.abs(x1 - x0) < 0.0000000001) break;
            x0 = x1;
        }
        return x1;
    }
    
	private static double f0(double x) {
	    return x * x - 2;  
	}
	private static double f1(double x) {
	    return 2 * x;  
	}
}
