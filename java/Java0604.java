public class Java0604 {

    private static double f(double x) {
        return 4 / (1 + x * x); 
    }

    public static void main(String []args) {
        final double a = 0;
        final double b = 1;

        double[][] t = new double[7][7];

        // ‘äŒ`‘¥‚ÅÏ•ª
        int n = 2;
        for (int i = 1; i <= 6; i++) {
            double h = (b - a) / n;  
            double s = 0;
            double x = a;
            for (int j = 1; j <= n - 1; j++) {
                x += h;
                s += f(x);
            }
            // Œ‹‰Ê‚ğ•Û‘¶
            t[i][1] = h * ((f(a) + f(b)) / 2 + s);
            n *= 2;
        }

        // Richardson‚Ì•âŠO–@
        n = 4;
        for (int j = 2; j <= 6; j++) {
            for (int i = j; i <= 6; i++) {
                t[i][j] = t[i][j - 1] + (t[i][j - 1] - t[i - 1][j - 1]) / (n - 1);
                if (i == j) {
                    // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
                    System.out.println(String.format("%2d : %13.10f, %13.10f", j, t[i][j], t[i][j] - Math.PI));
                }
            }
            n *= 4;
        }
    }
}
