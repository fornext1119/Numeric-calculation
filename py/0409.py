# coding: Shift_JIS

# �g����
def Comb(n, r):
    if (r == 0 or r == n):
        return 1
    elif (r == 1):
        return n
    else:
        return Comb(n - 1, r - 1) + Comb(n - 1, r)

# �d���g���� (�قȂ� 10 �̂��̂���d���������� 5 �Ƃ�g�����̑���)
n = 10
r = 5
print Comb(n + r - 1, r)
