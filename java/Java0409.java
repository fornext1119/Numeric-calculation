public class Java0409 {

    // �g����
    private static int Comb(int n, int r)
    {
        if (r == 0 || r == n)
            return 1;
        else if (r == 1)
            return n;
        elsereturn Comb(n - 1, r - 1) + Comb(n - 1, r);
    }

     public static void main(String []args) {
        // �d���g���� (�قȂ� 10 �̂��̂���d���������� 5 �Ƃ�g�����̑���)
        int n = 10;
        int r = 5;
        System.out.println(Comb(n + r - 1, r));
    }
}
