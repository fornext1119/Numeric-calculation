public class Java0301 {
     public static void main(String []args) {
        // 3 ‚Ì”{”‚Ì‡Œv
        System.out.println( sn(3, 999) );
     }
    // ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
    private static int sn(int a, int lim) {
        int n = lim / a;        // €”:n  =  ãŒÀ:lim / Œö·:a
        int l = n * a;          // ––€:l  =  €”:n   * Œö·:a
        return (a + l) * n / 2; // ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
    }
}
