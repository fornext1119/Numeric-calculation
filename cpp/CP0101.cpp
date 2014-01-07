#include <iostream.h>
#include <iomanip>
#include <math.h>
using namespace std;

int main()
{
    cout << 3 + 5     << endl;
    cout << 3 - 5     << endl;
    cout << 3 * 5     << endl;
    cout << pow(3, 5) << endl;
    cout << 5 / 3     << endl;
    cout << 5.0 / 3   << endl;
    cout << 5 / 3.0   << endl;
    cout << 5 % 3     << endl;

    cout << setw(3)  <<                              3 * 5   << endl;
    cout << setw(23) << fixed << setprecision(20) << 5 / 3.0 << endl;

    return 0;
}
