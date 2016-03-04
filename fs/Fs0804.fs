module Fs0804

open System

// d—Í‰Á‘¬“x
let g = -9.8
// ‹ó‹C’ïRŒW”
let k = -0.01
// ŽžŠÔŠÔŠu(•b)
let h = 0.01

// Šp“x
let degree = 45.0
let radian = degree * Math.PI / 180.0
// ‰‘¬ 250 km/h -> •b‘¬‚É•ÏŠ·
let v = float(250 * 1000 / 3600)
// …•½•ûŒü‚Ì‘¬“x
let vx = v * Math.Cos(radian)
// ‰”’¼•ûŒü‚Ì‘¬“x
let vy = v * Math.Sin(radian)
// ˆÊ’u
let x = 0.0
let y = 0.0

// ‹ó‹C’ïR‚É‚æ‚é…•½•ûŒü‚ÌŒ¸‘¬•ª
let fx(vx:Double) (vy:Double) = 
    k * Math.Sqrt(vx * vx + vy * vy) * vx
// d—Í‚Æ‹ó‹C’ïR‚É‚æ‚é‰”’¼•ûŒü‚ÌŒ¸‘¬•ª
let fy(vx:Double) (vy:Double) = 
    g + (k * Math.Sqrt(vx * vx + vy * vy) * vy)

// Runge-Kutta–@
let rec rungekutta(i:int) (vx:double) (vy:double) (x:double) (y:double):unit = 
    // Œo‰ß•b”
    let t = float(i) * h

    // ˆÊ’uE‘¬“x
    let wx1  = h *     vx
    let wy1  = h *     vy
    let wvx1 = h * (fx vx vy)
    let wvy1 = h * (fy vx vy)

    let wvx5 = vx + wvx1 / 2.0
    let wvy5 = vy + wvy1 / 2.0
    let wx2  = h *     wvx5
    let wy2  = h *     wvy5
    let wvx2 = h * (fx wvx5 wvy5)
    let wvy2 = h * (fy wvx5 wvy5)

    let wvx6 = vx + wvx2 / 2.0
    let wvy6 = vy + wvy2 / 2.0
    let wx3  = h *     wvx6
    let wy3  = h *     wvy6
    let wvx3 = h * (fx wvx6 wvy6)
    let wvy3 = h * (fy wvx6 wvy6)

    let wvx7 = vx + wvx3
    let wvy7 = vy + wvy3
    let wx4  = h *     wvx7
    let wy4  = h *     wvy7
    let wvx4 = h * (fx wvx7 wvy7)
    let wvy4 = h * (fy wvx7 wvy7)

    let wx  = x  + ( wx1 +  wx2 * 2.0 +  wx3 * 2.0 +  wx4) / 6.0
    let wy  = y  + ( wy1 +  wy2 * 2.0 +  wy3 * 2.0 +  wy4) / 6.0
    let wvx = vx + (wvx1 + wvx2 * 2.0 + wvx3 * 2.0 + wvx4) / 6.0
    let wvy = vy + (wvy1 + wvy2 * 2.0 + wvy3 * 2.0 + wvy4) / 6.0

    printfn "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f" t wvx wvy wx wy

    if wy >= 0.0 then
        (rungekutta (i+1) wvx wvy wx wy)
    else
        ()

// Runge-Kutta–@
(rungekutta 1 vx vy x y)

exit 0
