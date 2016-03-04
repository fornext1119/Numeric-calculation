public class Java0602 {

    private static double f(double x) {
        return 4 / (1 + x * x); 
    }

    public static void main(String []args) {
        final double a = 0;
        final double b = 1;

        // ’†“_‘¥‚ÅÏ•ª
        int n = 2;
        for (int j = 1; j <= 10; j++) {
            double h = (b - a) / n;  
            double s = 0;
            double x = a + (h / 2);
            for (int i = 1; i <= n; i++) {
                s += f(x);
                x += h;
            }
            s *= h;
            n *= 2;

            // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
            System.out.println(String.format("%2d : %13.10f, %13.10f", j, s, s - Math.PI));
        }
    }
}
