public class Java0406 {

    // 階乗
    private static int Fact(int n) {
        if (n <= 1)
            return 1;
        else
            return n * Fact(n - 1);
    }

    // 下降階乗冪
    private static int FallingFact(int x, int n) {
        if (n <= 1)
            return x;
        else
            return x * FallingFact(x - 1, n - 1);
    }

     public static void main(String []args) {
        // 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
        int n = 10;
        int r = 5;
        System.out.println(Fact(n) / Fact(n - r));
        System.out.println(FallingFact(n, r));
    }
}
