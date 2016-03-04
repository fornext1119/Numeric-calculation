# coding: Shift_JIS

import math

# �d�͉����x
g = -9.8
# ��C��R�W��
k = -0.01
# ���ԊԊu(�b)
h = 0.01

# �p�x
degree = 45
radian = degree * math.pi / 180.0
# ���� 250 km/h -> �b���ɕϊ�
v = int(250 * 1000 / 3600)
# ���������̑��x
vx = [0 for i in range(3)]
vx[0] = v * math.cos(radian)
# ���������̑��x
vy = [0 for i in range(3)]
vy[0] = v * math.sin(radian)
# �o�ߕb��
t = 0.0
# �ʒu
x = [0 for i in range(3)]
x[0] = 0.0
y = [0 for i in range(3)]
y[0] = 0.0

# ��C��R�ɂ�鐅�������̌�����
def fx(vx, vy):
    return k * math.sqrt(vx * vx + vy * vy) * vx

# �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
def fy(vx, vy):
    return g + (k * math.sqrt(vx * vx + vy * vy) * vy)

# Heun�@
i = 1
while y[0] >= 0.0:
    # �o�ߕb��
    t = i * h

    # �ʒu�E���x
    x[1]  =  x[0] + h *    vx[0]
    y[1]  =  y[0] + h *    vy[0]
    vx[1] = vx[0] + h * fx(vx[0], vy[0])
    vy[1] = vy[0] + h * fy(vx[0], vy[0])

    x[2]  =  x[0] + h * (  vx[0]          +    vx[1]        ) / 2
    y[2]  =  y[0] + h * (  vy[0]          +    vy[1]        ) / 2
    vx[2] = vx[0] + h * (fx(vx[0], vy[0]) + fx(vx[1], vy[1])) / 2
    vy[2] = vy[0] + h * (fy(vx[0], vy[0]) + fy(vx[1], vy[1])) / 2

    x[0]  =  x[2]
    y[0]  =  y[2]
    vx[0] = vx[2]
    vy[0] = vy[2]

    print "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f" % (t, vx[0], vy[0], x[0], y[0])

    i += 1
