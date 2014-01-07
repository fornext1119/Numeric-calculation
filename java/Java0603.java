public class Java0603 {

    private static double f(double x) {
        return 4 / (1 + x * x); 
    }

    public static void main(String []args) {
        final double a = 0;
        final double b = 1;

        // Simpson‘¥‚ÅÏ•ª
        int n = 2;
        for (int j = 1; j <= 5; j++) {
            double h  = (b - a) / n;  
            double s2 = 0;
            double s4 = 0;
            double x  = a + h;
            for (int i = 1; i <= n / 2; i++) {
                s4 += f(x);
                x  += h;
                s2 += f(x);
                x  += h;
            }
            s2 = (s2 - f(b)) * 2 + f(a) + f(b);
            s4 *= 4;
            double s = (s2 + s4) * h / 3;
            n *= 2;

            // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
            System.out.println(String.format("%2d : %13.10f, %13.10f", j, s, s - Math.PI));
        }
    }
}
