#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
    int sum = 0;
    int i;
    for (i = 1; i < 100; i++)
    {
        if (i % 3 == 0)
        {
            sum += i;
        }
    }
    printf("%d\n", sum);

    return 0;
}
