using System;

public class CS0403
{
    // �K������߂�֐�
    private static int Fact(int n)
    {
        if (n <= 1)
            return 1;
        else
            return n * Fact(n - 1);
    }

    public static void Main()
    {
        // 10�̊K��
        Console.WriteLine(Fact(10));
        Console.WriteLine(10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1);
    }
}
