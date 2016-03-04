# coding: Shift_JIS

N = 4

# １次元配列を表示
def disp_vector(row):
    for col in row:
        print "%14.10f\t" % col,
    print ""

# ガウス・ザイデル法
def gauss(a, b, x0):
    while True:
        x1 = 0.0
        finish = True
        for i in range(0, N, 1):
            x1 = 0
            for j in range(0, N, 1):
                if (j != i):
                    x1 += a[i][j] * x0[j]

            x1 = (b[i] - x1) / a[i][i]
            if (abs(x1 - x0[i]) > 0.0000000001):
                finish = False
            x0[i] = x1

        if (finish):
            return

        disp_vector(x0)

a = [[ 9.0,  2.0, 1.0,  1.0], [2.0, 8.0, -2.0, 1.0], [-1.0, -2.0, 7.0, -2.0], [1.0, -1.0, -2.0, 6.0]] 
b =  [20.0, 16.0, 8.0, 17.0]
c =  [ 0.0,  0.0, 0.0,  0.0]

# ガウス・ザイデル法
gauss(a,b,c)

print "X"
disp_vector(c)
