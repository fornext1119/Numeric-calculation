# coding: Shift_JIS

# �f�[�^�_�̐�
N = 7

# ���̊֐�
def f(x):
    return x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)

# Spline (�X�v���C��) ���
def spline(d, x, y, z):
    # ��Ԋ֐��l���ǂ̋�Ԃɂ��邩
    k = -1
    for i in range(1, N):
        if d <= x[i]:
            k = i - 1
            break
    if (k < 0):
        k = N - 1

    d1 = x[k+1] - d
    d2 = d      - x[k]
    d3 = x[k+1] - x[k]
    return ( (z[k] * (d1 ** 3) + z[k+1] * (d2 ** 3)) / (6.0 * d3)
           + (y[k]   / d3 - z[k]   * d3 / 6.0) * d1
           + (y[k+1] / d3 - z[k+1] * d3 / 6.0) * d2)

x = [0 for i in range(N)]
y = [0 for i in range(N)]

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
for i in range(0, N):
    d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)

# �R���������̌W���̕\�����
a = [0 for i in range(N)]
b = [0 for i in range(N)]
c = [0 for i in range(N)]
d = [0 for i in range(N)]
for i in range(1, N - 1):
    a[i] =         x[i]   - x[i-1] 
    b[i] = 2.0 *  (x[i+1] - x[i-1]) 
    c[i] =         x[i+1] - x[i] 
    d[i] = 6.0 * ((y[i+1] - y[i]) / (x[i+1] - x[i]) - (y[i] - y[i-1]) / (x[i] - x[i-1]))

# �R�������������� (�g�|�}�X�@)
g = [0 for i in range(N)]
s = [0 for i in range(N)]
g[1] = b[1]
s[1] = d[1]
for i in range(2, N - 1):
    g[i] = b[i] - a[i] * c[i-1] / g[i-1]
    s[i] = d[i] - a[i] * s[i-1] / g[i-1]

z = [0 for i in range(N)]
z[0]   = 0
z[N-1] = 0
z[N-2] = s[N-2] / g[N-2]
i = N - 3
while i >= 1:
    z[i] = (s[i] - c[i] * z[i+1]) / g[i]
    i -= 1

# 0.5���݂� �^�����Ă��Ȃ��l���� 
for i in range(0, 19):
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = spline(d1, x, y, z)

    # ���̊֐��Ɣ�r
    print "%5.2f\t%8.5f\t%8.5f\t%8.5f" % (d1, d2, d3, d2 - d3)
