# coding: Shift_JIS

N = 4

# �O�i����
def forward_elimination(a, b):
    for pivot in range(0, N - 1, 1):
        for row in range(pivot + 1, N, 1):
            s = a[row][pivot] / a[pivot][pivot]
            for col in range(pivot, N, 1):
                a[row][col] -= a[pivot][col]    * s
            b[row]          -= b[pivot]         * s

# ��ޑ��
def backward_substitution(a, b):
    for row in range(N - 1, -1, -1):
        for col in range(N - 1, row, -1):
            b[row] -= a[row][col] * b[col]
        b[row] /= a[row][row]

# �s�{�b�g�I��
def pivoting(a, b):
    for pivot in range(0, N, 1):
        # �e��� ��Ԓl���傫���s�� �T��
        max_row =   pivot
        max_val =   0.0
        for row in range(pivot, N, 1):
            if (abs(a[row][pivot]) > max_val):
                # ��Ԓl���傫���s
                max_val =   abs(a[row][pivot])
                max_row =   row

        # ��Ԓl���傫���s�Ɠ���ւ�
        if (max_row != pivot):
            tmp = 0.0
            for col in range(0, N, 1):
                tmp             =   a[max_row][col]
                a[max_row][col] =   a[pivot][col]
                a[pivot][col]   =   tmp
            tmp        =   b[max_row]
            b[max_row] =   b[pivot]
            b[pivot]   =   tmp

# �P�����z���\��
def disp_matrix(matrix):
    for row in matrix:
        for col in row:
            print "%14.10f\t" % col,
        print ""

# �Q�����z���\��
def disp_vector(row):
    for col in row:
        print "%14.10f\t" % col,
    print ""

a = [[-1.0, -2.0,  7.0, -2.0], [1.0, -1.0, -2.0, 6.0], [ 9.0,  2.0, 1.0,  1.0], [2.0, 8.0, -2.0, 1.0], ]
b =  [ 8.0, 17.0, 20.0, 16.0]
c =  [ 0.0,  0.0,  0.0,  0.0]

# �s�{�b�g�I��
pivoting(a,b)

print "pivoting"
print "A"
disp_matrix(a)
print "B"
disp_vector(b)
print ""

# �O�i����
forward_elimination(a,b)

print "forward elimination"
print "A"
disp_matrix(a)
print "B"
disp_vector(b)
print ""

# ��ޑ��
backward_substitution(a,b)

print "X"
disp_vector(b)
