public class Java0301 {
     public static void main(String []args) {
        // 3 �̔{���̍��v
        System.out.println( sn(3, 999) );
     }
    // ����:a, ����:a ��, ���:lim �̐���̑��a��Ԃ��֐�
    private static int sn(int a, int lim) {
        int n = lim / a;        // ����:n  =  ���:lim / ����:a
        int l = n * a;          // ����:l  =  ����:n   * ����:a
        return (a + l) * n / 2; // ���a:sn = (����:a   + ����:l) * ����:n / 2
    }
}
