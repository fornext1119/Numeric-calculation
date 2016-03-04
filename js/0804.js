// �d�͉����x
var g = -9.8
// ��C��R�W��
var k = -0.01
// ���ԊԊu(�b)
var h = 0.01

// �p�x
var degree = 45
var radian = degree * Math.PI / 180.0
// ���� 250 km/h -> �b���ɕϊ�
var v = parseInt(250 * 1000 / 3600)
// ���������̑��x
var vx = []
vx[0] = v * Math.cos(radian)
// ���������̑��x
var vy = []
vy[0] = v * Math.sin(radian)
// �o�ߕb��
var t = 0.0
// �ʒu
var x = []
x[0] = 0.0
var y = []
y[0] = 0.0

// Runge-Kutta�@
for (var i = 1; y[0] >= 0.0; i++)
{
    // �o�ߕb��
    t = i * h

    // �ʒu�E���x
    x[1]  = h *    vx[0]
    y[1]  = h *    vy[0]
    vx[1] = h * fx(vx[0], vy[0])
    vy[1] = h * fy(vx[0], vy[0])

    var wx = vx[0] + vx[1] / 2
    var wy = vy[0] + vy[1] / 2
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

    WScript.StdOut.Write(("    "      + t.toFixed(2)       ).slice(-4) + "\t")
    WScript.StdOut.Write(("        "  + vx[0].toFixed(5)   ).slice(-8) + "\t")
    WScript.StdOut.Write(("         " + vy[0].toFixed(5)   ).slice(-9) + "\t")
    WScript.StdOut.Write(("         " +  x[0].toFixed(5)   ).slice(-9) + "\t")
    WScript.StdOut.Write(("        "  +  y[0].toFixed(5)   ).slice(-8) + "\n")
}

// ��C��R�ɂ�鐅�������̌�����
function fx(vx, vy)
{
    return k * Math.sqrt(vx * vx + vy * vy) * vx
}
// �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
function fy(vx, vy)
{
    return g + (k * Math.sqrt(vx * vx + vy * vy) * vy)
}
