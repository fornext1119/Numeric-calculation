#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
    // 100 �܂ł� ���R���̂R��̘a
    int n = 100;
    printf("%d\n", (int)(pow(n, 2) * pow((n + 1), 2) / 4) ); 
    return 0;
}
