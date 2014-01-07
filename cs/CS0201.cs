using System.Linq;
using System.Collections.Generic;

public class CS0201
{
    public static void Main()
    {
        IEnumerable<int> squares = Enumerable.Range(1, 9);

        foreach (int num in squares)
        {
            System.Console.Write(num + ", ");
        }
        System.Console.WriteLine();
    }
}
