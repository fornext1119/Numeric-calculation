module Fs0802

open System

// �d�͉����x
let g = -9.8
// ��C��R�W��
let k = -0.01
// ���ԊԊu(�b)
let h = 0.01

// �p�x
let degree = 45.0
let radian = degree * Math.PI / 180.0
// ���� 250 km/h -> �b���ɕϊ�
let v = float(250 * 1000 / 3600)
// ���������̑��x
let vx = v * Math.Cos(radian)
// ���������̑��x
let vy = v * Math.Sin(radian)
// �ʒu
let x = 0.0
let y = 0.0

// ��C��R�ɂ�鐅�������̌�����
let fx(vx:Double) (vy:Double) = 
    k * Math.Sqrt(vx * vx + vy * vy) * vx
// �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
let fy(vx:Double) (vy:Double) = 
    g + (k * Math.Sqrt(vx * vx + vy * vy) * vy)

// Heun�@
let rec heun(i:int) (vx:double) (vy:double) (x:double) (y:double):unit = 
    // �o�ߕb��
    let t = float(i) * h

    // �ʒu�E���x
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

// Heun�@
(heun 1 vx vy x y)

exit 0
