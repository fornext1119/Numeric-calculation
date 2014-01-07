public class Java0403 {

    // ŠKæ‚ğ‹‚ß‚éŠÖ”
    private static int Fact(int n) {
        if (n <= 1)
            return 1;
        else
            return n * Fact(n - 1);
    }

     public static void main(String []args) {
        // 10‚ÌŠKæ
        System.out.println(Fact(10));
        System.out.println(10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1);
    }
}
