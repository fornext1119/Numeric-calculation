public class CS0307
{
    public static void Main()
    {
        // ���� 2, ���� 3, ���� 10 �̓��䐔��̘a
        int n = 10;
        int a = 2;
        int r = 3;
        System.Console.WriteLine( (a * (System.Math.Pow(r, n) - 1)) / (r - 1) );
     }
}
