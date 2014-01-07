#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
    int i;
    for (i = 1; i < 10; i++)
    {
        if (i % 3 == 0)
        {
            printf("%d, ", i);
        }
    }
    printf("\n");

    return 0;
}
