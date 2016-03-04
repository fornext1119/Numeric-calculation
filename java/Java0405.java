public class Java0405 {
    // ã¸ŠKæ™p
    private static int RisingFact(int x, int n) {
        if (n <= 1)
            return x;
        else
            return x * RisingFact(x + 1, n - 1);
    }

     public static void main(String []args) {
        // 10 ‚©‚ç 14 ‚Ü‚Å‚Ì ‘æ
        System.out.println(RisingFact(10, 5));
        System.out.println(10 * 11 * 12 * 13 * 14);
    }
}
