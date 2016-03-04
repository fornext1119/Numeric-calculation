# èdóÕâ¡ë¨ìx
$g = -9.8
# ãÛãCíÔçRåWêî
$k = -0.01
# éûä‘ä‘äu(ïb)
h = 0.01

# äpìx
degree = 45
radian = degree * Math::PI / 180.0
# èâë¨ 250 km/h -> ïbë¨Ç…ïœä∑
v = 250 * 1000 / 3600
# êÖïΩï˚å¸ÇÃë¨ìx
vx = Array.new(5)
vx[0] = v * Math.cos(radian)
# âîíºï˚å¸ÇÃë¨ìx
vy = Array.new(5)
vy[0] = v * Math.sin(radian)
# åoâﬂïbêî
t = 0.0
# à íu
x = Array.new(5)
x[0] = 0.0
y = Array.new(5)
y[0] = 0.0

# ãÛãCíÔçRÇ…ÇÊÇÈêÖïΩï˚å¸ÇÃå∏ë¨ï™
def fx(vx, vy)
    return $k * Math.sqrt(vx * vx + vy * vy) * vx
end

# èdóÕÇ∆ãÛãCíÔçRÇ…ÇÊÇÈâîíºï˚å¸ÇÃå∏ë¨ï™
def fy(vx, vy)
    return $g + ($k * Math.sqrt(vx * vx + vy * vy) * vy)
end

# Runge-Kuttañ@
i = 1
while y[0] >= 0.0 do
    # åoâﬂïbêî
    t = i * h

    # à íuÅEë¨ìx
    x[1]  = h *    vx[0]
    y[1]  = h *    vy[0]
    vx[1] = h * fx(vx[0], vy[0])
    vy[1] = h * fy(vx[0], vy[0])

    wx    = vx[0] + vx[1] / 2
    wy    = vy[0] + vy[1] / 2
    x[2]  = h *    wx
    y[2]  = h *    wy
    vx[2] = h * fx(wx, wy)
    vy[2] = h * fy(wx, wy)

    wx    = vx[0] + vx[2] / 2
    wy    = vy[0] + vy[2] / 2
    x[3]  = h *    wx
    y[3]  = h *    wy
    vx[3] = h * fx(wx, wy)
    vy[3] = h * fy(wx, wy)

    wx    = vx[0] + vx[3]
    wy    = vy[0] + vy[3]
    x[4]  = h *    wx
    y[4]  = h *    wy
    vx[4] = h * fx(wx, wy)
    vy[4] = h * fy(wx, wy)

    x[0]  += ( x[1] +  x[2] * 2 +  x[3] * 2 +  x[4]) / 6
    y[0]  += ( y[1] +  y[2] * 2 +  y[3] * 2 +  y[4]) / 6
    vx[0] += (vx[1] + vx[2] * 2 + vx[3] * 2 + vx[4]) / 6
    vy[0] += (vy[1] + vy[2] * 2 + vy[3] * 2 + vy[4]) / 6

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f\n", t, vx[0], vy[0], x[0], y[0])

    i += 1
end
