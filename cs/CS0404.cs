using System;

public class CS0404
{
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
        // 10 ���� 6 �܂ł� ����
        Console.WriteLine(FallingFact(10, 5));
        Console.WriteLine(10 * 9 * 8 * 7 * 6);
    }
}
