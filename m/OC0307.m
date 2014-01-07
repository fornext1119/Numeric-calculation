#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
    // ‰€ 2, Œö”ä 3, €” 10 ‚Ì“™”ä”—ñ‚Ì˜a
    int n = 10;
    int a = 2;
    int r = 3;
    printf("%d\n", (int)((a * (pow(r, n) - 1)) / (r - 1)) ); 
    return 0;
}
