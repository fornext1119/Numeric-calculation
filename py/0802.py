# coding: Shift_JIS

import math

# 重力加速度
g = -9.8
# 空気抵抗係数
k = -0.01
# 時間間隔(秒)
h = 0.01

# 角度
degree = 45
radian = degree * math.pi / 180.0
# 初速 250 km/h -> 秒速に変換
v = int(250 * 1000 / 3600)
# 水平方向の速度
vx = [0 for i in range(3)]
vx[0] = v * math.cos(radian)
# 鉛直方向の速度
vy = [0 for i in range(3)]
vy[0] = v * math.sin(radian)
# 経過秒数
t = 0.0
# 位置
x = [0 for i in range(3)]
x[0] = 0.0
y = [0 for i in range(3)]
y[0] = 0.0

# 空気抵抗による水平方向の減速分
def fx(vx, vy):
    return k * math.sqrt(vx * vx + vy * vy) * vx

# 重力と空気抵抗による鉛直方向の減速分
def fy(vx, vy):
    return g + (k * math.sqrt(vx * vx + vy * vy) * vy)

# Heun法
i = 1
while y[0] >= 0.0:
    # 経過秒数
    t = i * h

    # 位置・速度
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
