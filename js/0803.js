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

// ���_�@
for (var i = 1; y[0] >= 0.0; i++)
{
    // �o�ߕb��
    t = i * h

    // �ʒu�E���x
    vx[1] = h * fx(vx[0], vy[0])
    vy[1] = h * fy(vx[0], vy[0])
    
    var wx = vx[0] + vx[1] / 2.0
    var wy = vy[0] + vy[1] / 2.0
    vx[0]  = vx[0] + h * fx(wx, wy)
    vy[0]  = vy[0] + h * fy(wx, wy)
    x[0]   = x[0]  + h *    wx
    y[0]   = y[0]  + h *    wy

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
