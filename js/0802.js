// 重力加速度
var g = -9.8
// 空気抵抗係数
var k = -0.01
// 時間間隔(秒)
var h = 0.01

// 角度
var degree = 45
var radian = degree * Math.PI / 180.0
// 初速 250 km/h -> 秒速に変換
var v = parseInt(250 * 1000 / 3600)
// 水平方向の速度
var vx = []
vx[0] = v * Math.cos(radian)
// 鉛直方向の速度
var vy = []
vy[0] = v * Math.sin(radian)
// 経過秒数
var t = 0.0
// 位置
var x = []
x[0] = 0.0
var y = []
y[0] = 0.0

// Heun法
for (var i = 1; y[0] >= 0.0; i++)
{
    // 経過秒数
    t = i * h

    // 位置・速度
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

    WScript.StdOut.Write(("    "      + t.toFixed(2)       ).slice(-4) + "\t")
    WScript.StdOut.Write(("        "  + vx[0].toFixed(5)   ).slice(-8) + "\t")
    WScript.StdOut.Write(("         " + vy[0].toFixed(5)   ).slice(-9) + "\t")
    WScript.StdOut.Write(("         " +  x[0].toFixed(5)   ).slice(-9) + "\t")
    WScript.StdOut.Write(("        "  +  y[0].toFixed(5)   ).slice(-8) + "\n")
}

// 空気抵抗による水平方向の減速分
function fx(vx, vy)
{
    return k * Math.sqrt(vx * vx + vy * vy) * vx
}
// 重力と空気抵抗による鉛直方向の減速分
function fy(vx, vy)
{
    return g + (k * Math.sqrt(vx * vx + vy * vy) * vy)
}
