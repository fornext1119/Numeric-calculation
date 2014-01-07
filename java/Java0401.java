public class Java0401 {
    public static void main(String []args) {
        int a = 5;   // ‰€ 5
        int d = 3;   // Œö· 3
        int n = 10;  // €” 10
        long p = 1;  // Ï

        for (int i = 1; i <= n; i++) {
            int m = a + (d * (i - 1));
            p *= m;
        }
        System.out.println(p);
    }
}
