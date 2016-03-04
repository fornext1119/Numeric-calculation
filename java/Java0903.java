import static java.lang.System.out;

public class Java0903 {

    public static void main(String []args) {
        double x = 1;
        out.println(String.format("%12.10f", iterative(x)));
    }

    private static double iterative(double x0) {
        double x1;
        while (true) {
            x1 = g(x0);
            out.println(String.format("%12.10f\t%13.10f", x1, x1 - Math.sqrt(2)));

            if (Math.abs(x1 - x0) < 0.0000000001) break;
            x0 = x1;
        }
        return x1;
    }
    
    private static double g(double x) {
        return (x / 2) + (1 / x);
    }
}
