using System;

public class CS0406
{
    // �K��
    private static int Fact(int n)
    {
        if (n <= 1)
            return 1;
        else
            return n * Fact(n - 1);
    }

    // ���~�K��p
    private static int FallingFact(int x, int n)
    {
        if (n <= 1)
            return x;
        else
            return x * FallingFact(x - 1, n - 1);
    }

    public static void Main()
    {
        // ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
        int n = 10;
        int r = 5;
        Console.WriteLine(Fact(n) / Fact(n - r));
        Console.WriteLine(FallingFact(n, r));
    }
}
