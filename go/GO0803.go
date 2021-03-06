package main

import "fmt"
import "math"

// 重力加速度
const g float64 = -9.8
// 空気抵抗係数
const k float64 = -0.01
// 時間間隔(秒)
const h float64 = 0.01

func main() {
    // 角度
    var degree float64 = 45
    var radian float64 = degree * math.Pi / 180.0
    // 初速 250 km/h -> 秒速に変換
    var v float64 = 250 * 1000 / 3600
    // 水平方向の速度
    var vx[2] float64
    vx[0] = v * math.Cos(radian)
    // 鉛直方向の速度
    var vy[2] float64
    vy[0] = v * math.Sin(radian)
    // 経過秒数
    var t float64 = 0.0
    // 位置
    var x[2] float64
    x[0] = 0.0
    var y[2] float64
    y[0] = 0.0

    // 中点法
    for i := 1; y[0] >= 0.0; i++ {
        // 経過秒数
        t = float64(i) * h

        // 位置・速度
        vx[1] = h * fx(vx[0], vy[0])
        vy[1] = h * fy(vx[0], vy[0])
        
        var wx float64 = vx[0] + vx[1] / 2
        var wy float64 = vy[0] + vy[1] / 2
        vx[0]     = vx[0] + h * fx(wx, wy)
        vy[0]     = vy[0] + h * fy(wx, wy)
        x[0]      =  x[0] + h *    wx
        y[0]      =  y[0] + h *    wy

        fmt.Printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f\n", t, vx[0], vy[0], x[0], y[0])
    }
}

// 空気抵抗による水平方向の減速分
func fx(vx float64, vy float64) float64 {
    return k * math.Sqrt(vx * vx + vy * vy) * vx
}
// 重力と空気抵抗による鉛直方向の減速分
func fy(vx float64, vy float64) float64 {
    return g + (k * math.Sqrt(vx * vx + vy * vy) * vy)
}
