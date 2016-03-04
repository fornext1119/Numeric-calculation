module Fs0803

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

// ’†“_–@
let rec midpoint(i:int) (vx:double) (vy:double) (x:double) (y:double):unit = 
    // Œo‰ß•b”
    let t = float(i) * h

    // ˆÊ’uE‘¬“x
    let wvx1 = h * (fx vx vy)
    let wvy1 = h * (fy vx vy)
    let wvx2 = vx + wvx1 / 2.0
    let wvy2 = vy + wvy1 / 2.0

    let wvx = vx + h * (fx wvx2 wvy2)
    let wvy = vy + h * (fy wvx2 wvy2)
    let wx  = x  + h *     wvx2
    let wy  = y  + h *     wvy2

    printfn "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f" t wvx wvy wx wy

    if wy >= 0.0 then
        (midpoint (i+1) wvx wvy wx wy)
    else
        ()

// ’†“_–@
(midpoint 1 vx vy x y)

exit 0
