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
var x = 0.0
var y = 0.0

// Euler�@
for (var i = 1; y >= 0.0; i++)
{
    // �o�ߕb��
    t = i * h

    // �ʒu
    x += h * vx[0]
    y += h * vy[0]

    WScript.StdOut.Write(("    "      + t.toFixed(2)       ).slice(-4) + "\t")
    WScript.StdOut.Write(("        "  + vx[0].toFixed(5)   ).slice(-8) + "\t")
    WScript.StdOut.Write(("         " + vy[0].toFixed(5)   ).slice(-9) + "\t")
    WScript.StdOut.Write(("         " + x.toFixed(5)       ).slice(-9) + "\t")
    WScript.StdOut.Write(("        "  + y.toFixed(5)       ).slice(-8) + "\n")

    // ���x
    vx[1] = vx[0] + h * fx(vx[0], vy[0])
    vy[1] = vy[0] + h * fy(vx[0], vy[0])
    vx[0] = vx[1]
    vy[0] = vy[1]
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
