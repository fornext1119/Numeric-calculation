public class CS0105
{
    public static void Main()
    {
        int sum = 0;
        for (int i = 1; i < 100; i++)
        {
            if (i % 3 == 0)
            {
                sum += i;
            }
        }
        System.Console.WriteLine(sum);
    }
}
