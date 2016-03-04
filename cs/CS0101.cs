public class CS0101
{
    public static void Main()
    {
        System.Console.WriteLine(3 + 5);
        System.Console.WriteLine(3 - 5);
        System.Console.WriteLine(3 * 5);
        System.Console.WriteLine(System.Math.Pow(3, 5));
        System.Console.WriteLine(5 / 3);
        System.Console.WriteLine(5.0 / 3);
        System.Console.WriteLine(5 / 3.0);
        System.Console.WriteLine(5 % 3);

        System.Console.Write(3 * 5 + "\n");

        System.Console.WriteLine(string.Format("{0,3:D}",    3 * 5));
        System.Console.WriteLine(string.Format("{0,23:F20}", 5 / 3.0));
    }
}
