using System.Linq;

public class CS0203
{
    public static void Main()
    {
        int sum = Enumerable.Range(1, 99).Where(num => (num % 3 == 0)).Sum();
        System.Console.WriteLine(sum);

        sum = Enumerable.Range(1, 99).Where(num => (num % 3 == 0)).Aggregate((x, n) => x + n);
        System.Console.WriteLine(sum);
    }
}
