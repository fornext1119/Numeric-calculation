#include <iostream.h>

int main()
{
    int sum = 0;
    for (int i = 1; i < 100; i++)
    {
        if (i % 3 == 0)
        {
            sum += i;
        }
    }
    cout << sum << endl;;

    return 0;
}
