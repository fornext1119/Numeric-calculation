module Fs0802

open System

// 重力加速度
let g = -9.8
// 空気抵抗係数
let k = -0.01
// 時間間隔(秒)
let h = 0.01

// 角度
let degree = 45.0
let radian = degree * Math.PI / 180.0
// 初速 250 km/h -> 秒速に変換
let v = float(250 * 1000 / 3600)
// 水平方向の速度
let vx = v * Math.Cos(radian)
// 鉛直方向の速度
let vy = v * Math.Sin(radian)
// 位置
let x = 0.0
let y = 0.0

// 空気抵抗による水平方向の減速分
let fx(vx:Double) (vy:Double) = 
    k * Math.Sqrt(vx * vx + vy * vy) * vx
// 重力と空気抵抗による鉛直方向の減速分
let fy(vx:Double) (vy:Double) = 
    g + (k * Math.Sqrt(vx * vx + vy * vy) * vy)

// Heun法
let rec heun(i:int) (vx:double) (vy:double) (x:double) (y:double):unit = 
    // 経過秒数
    let t = float(i) * h

    // 位置・速度
    let wx2  =  x + h *     vx
    let wy2  =  y + h *     vy
    let wvx2 = vx + h * (fx vx vy)
    let wvy2 = vy + h * (fy vx vy)

    let wx   =  x + h * (    vx     +     wvx2      ) / 2.0
    let wy   =  y + h * (    vy     +     wvy2      ) / 2.0
    let wvx  = vx + h * ((fx vx vy) + (fx wvx2 wvy2)) / 2.0
    let wvy  = vy + h * ((fy vx vy) + (fy wvx2 wvy2)) / 2.0

    printfn "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f" t wvx wvy wx wy

    if wy >= 0.0 then
        (heun (i+1) wvx wvy wx wy)
    else
        ()

// Heun法
(heun 1 vx vy x y)

exit 0
