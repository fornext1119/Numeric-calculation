public class Java0404 {
    // ‰º~ŠKæ™p
    private static int FallingFact(int x, int n) {
        if (n <= 1)
            return x;
        else
            return x * FallingFact(x - 1, n - 1);
    }

     public static void main(String []args) {
        // 10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
        System.out.println(FallingFact(10, 5));
        System.out.println(10 * 9 * 8 * 7 * 6);
    }
}
