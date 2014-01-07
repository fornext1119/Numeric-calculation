public class Java0406 {

    // ŠKæ
    private static int Fact(int n) {
        if (n <= 1)
            return 1;
        else
            return n * Fact(n - 1);
    }

    // ‰º~ŠKæ™p
    private static int FallingFact(int x, int n) {
        if (n <= 1)
            return x;
        else
            return x * FallingFact(x - 1, n - 1);
    }

     public static void main(String []args) {
        // ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
        int n = 10;
        int r = 5;
        System.out.println(Fact(n) / Fact(n - r));
        System.out.println(FallingFact(n, r));
    }
}
