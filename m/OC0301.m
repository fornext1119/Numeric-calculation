#import <Foundation/Foundation.h>

int sn(int a, int lim);

int main (int argc, const char * argv[])
{
    // 3 ‚Ì”{”‚Ì‡Œv
    printf("%d\n", sn(3, 999));
    return 0;
}
// ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
int sn(int a, int lim)
{
    int n = lim / a;        // €”:n  =  ãŒÀ:lim / Œö·:a
    int l = n * a;          // ––€:l  =  €”:n   * Œö·:a
    return (a + l) * n / 2; // ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
}
