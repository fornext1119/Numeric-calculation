using System;

public class CS040101
{
    // �g����
    private static int Comb(int n, int r)
    {
        if (r == 0 || r == n)
            return 1;
        else if (r == 1)
            return n;
        else
            return Comb(n - 1, r - 1) + Comb(n - 1, r);
    }

    public static void Main()
    {
        // �g���� (�قȂ� 10 �̂��̂��� 5 ����Ăł���g�����̑���)
        int n = 10;
        int r = 5;
        Console.WriteLine(Comb(n, r));
    }
}
