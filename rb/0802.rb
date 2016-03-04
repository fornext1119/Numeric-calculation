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
vx = Array.new(3)
vx[0] = v * Math.cos(radian)
# âîíºï˚å¸ÇÃë¨ìx
vy = Array.new(3)
vy[0] = v * Math.sin(radian)
# åoâﬂïbêî
t = 0.0
# à íu
x = Array.new(3)
x[0] = 0.0
y = Array.new(3)
y[0] = 0.0

# ãÛãCíÔçRÇ…ÇÊÇÈêÖïΩï˚å¸ÇÃå∏ë¨ï™
def fx(vx, vy)
    return $k * Math.sqrt(vx * vx + vy * vy) * vx
end

# èdóÕÇ∆ãÛãCíÔçRÇ…ÇÊÇÈâîíºï˚å¸ÇÃå∏ë¨ï™
def fy(vx, vy)
    return $g + ($k * Math.sqrt(vx * vx + vy * vy) * vy)
end

# Heunñ@
i = 1
while y[0] >= 0.0 do
    # åoâﬂïbêî
    t = i * h

    # à íuÅEë¨ìx
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

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n", t, vx[0], vy[0], x[0], y[0])

    i += 1
end
