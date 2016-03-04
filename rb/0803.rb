# �d�͉����x
$g = -9.8
# ��C��R�W��
$k = -0.01
# ���ԊԊu(�b)
h = 0.01

# �p�x
degree = 45
radian = degree * Math::PI / 180.0
# ���� 250 km/h -> �b���ɕϊ�
v = 250 * 1000 / 3600
# ���������̑��x
vx = Array.new(2)
vx[0] = v * Math.cos(radian)
# ���������̑��x
vy = Array.new(2)
vy[0] = v * Math.sin(radian)
# �o�ߕb��
t = 0.0
# �ʒu
x = Array.new(2)
x[0] = 0.0
y = Array.new(2)
y[0] = 0.0

# ��C��R�ɂ�鐅�������̌�����
def fx(vx, vy)
    return $k * Math.sqrt(vx * vx + vy * vy) * vx
end

# �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
def fy(vx, vy)
    return $g + ($k * Math.sqrt(vx * vx + vy * vy) * vy)
end

# ���_�@
i = 1
while y[0] >= 0.0 do
    # �o�ߕb��
    t = i * h

    # �ʒu�E���x
    vx[1] = h * fx(vx[0], vy[0])
    vy[1] = h * fy(vx[0], vy[0])
    
    wx    = vx[0] + vx[1] / 2.0
    wy    = vy[0] + vy[1] / 2.0
    vx[0] = vx[0] + h * fx(wx, wy)
    vy[0] = vy[0] + h * fy(wx, wy)
    x[0]  = x[0]  + h *    wx
    y[0]  = y[0]  + h *    wy

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f\n", t, vx[0], vy[0], x[0], y[0])

    i += 1
end
