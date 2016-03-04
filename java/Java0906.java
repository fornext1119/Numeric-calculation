import static java.lang.System.out;

public class Java0906 {

    public static void main(String []args) {
        double x0 = 1;
        double x1 = 2;
        out.println(String.format("%12.10f", secant(x0, x1)));
    }

    private static double secant(double x0, double x1) {
        double x2;
        while (true) {
            x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
            out.println(String.format("%12.10f\t%13.10f", x2, x2 - Math.sqrt(2)));

            if (Math.abs(x2 - x1) < 0.0000000001) break;
            x0 = x1;
            x1 = x2;
        }
        return x2;
    }
    
	private static double f(double x) {
	    return x * x - 2;  
	}
}
