# coding: Shift_JIS

import math

N = 4

# 前進消去
def forward_elimination(a, b):
    for pivot in range(0, N, 1):
        s = 0.0
        for col in range(0, pivot, 1):
            s += a[pivot][col] * a[pivot][col]
        a[pivot][pivot] = math.sqrt(a[pivot][pivot] - s)

        for row in range(pivot + 1, N, 1):
            s = 0.0
            for col in range(0, pivot, 1):
                s += a[row][col] * a[pivot][col]
            a[row][pivot] = (a[row][pivot] - s) / a[pivot][pivot]
            a[pivot][row] = a[row][pivot]

# 前進代入
def forward_substitution(a, b, y):
    for row in range(0, N, 1):
        for col in range(0, row + 1, 1):
            b[row] -= a[row][col] * y[col]

        y[row] = b[row] / a[row][row]

# 後退代入
def backward_substitution(a, y, x):
    for row in range(N - 1, -1, -1):
        for col in range(N - 1, row, -1):
            y[row] -= a[row][col] * x[col]
        x[row] = y[row] / a[row][row]

# ２次元配列を表示
def disp_matrix(matrix):
    for row in matrix:
        for col in row:
            print "%14.10f\t" % col,
        print ""

# １次元配列を表示
def disp_vector(row):
    for col in row:
        print "%14.10f\t" % col,
    print ""

a = [[5.0,2.0,3.0,4.0],[2.0,10.0,6.0,7.0],[3.0,6.0,15.0,9.0],[4.0,7.0,9.0,20.0]]
b =  [34.0,68.0,96.0,125.0]

print "A"
disp_matrix(a)
print "B"
disp_vector(b)
print ""

# 前進消去
forward_elimination(a,b)

print "LL^T"
disp_matrix(a)

# Ly=b から y を求める (前進代入)
y = [0.0, 0.0, 0.0, 0.0]
forward_substitution(a,b,y)

print "Y"
disp_vector(y)

# L^Tx=y から x を求める (後退代入)
x =  [ 0.0,  0.0,  0.0,  0.0]
backward_substitution(a,y,x)

print "X"
disp_vector(x)
