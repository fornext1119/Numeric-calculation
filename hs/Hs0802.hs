import Text.Printf

-- �d�͉����x
g = -9.8 :: Double
-- ��C��R�W��
k = -0.01 :: Double
-- ���ԊԊu(�b)
h = 0.01 :: Double

-- ��C��R�ɂ�鐅�������̌�����
fx::Double->Double->Double
fx vx vy = 
    let
        v = sqrt(vx * vx + vy * vy)
    in
        k * v * vx
    
-- ��C��R�ɂ�鉔�������̌�����
fy::Double->Double->Double
fy vx vy = 
    let
        v = sqrt(vx * vx + vy * vy)
    in
        g + (k * v * vy)

-- Heun�@
heun::Integer->Double->Double->Double->Double->IO ()
heun i vx vy x y =
    let 
        t = (fromIntegral i) * h

        wx2  =  x + h *     vx
        wy2  =  y + h *     vy
        wvx2 = vx + h * (fx vx vy)
        wvy2 = vy + h * (fy vx vy)

        wx   =  x + h * (    vx     +     wvx2      ) / 2.0
        wy   =  y + h * (    vy     +     wvy2      ) / 2.0
        wvx  = vx + h * ((fx vx vy) + (fx wvx2 wvy2)) / 2.0
        wvy  = vy + h * ((fy vx vy) + (fy wvx2 wvy2)) / 2.0
    in
        if y >= 0.0
            then do
                printf "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n" t wvx wvy wx wy
                heun (i+1) wvx wvy wx wy
            else
                return ()

main = do
    -- �p�x
    let degree = 45.0 :: Double
    let radian = degree * pi / 180.0
    -- ���� 250 km/h -> �b���ɕϊ�
    let v = (fromIntegral (250 * 1000 `div` 3600))

    -- ���������̑��x
    let vx = v * cos(radian)
    -- ���������̑��x
    let vy = v * sin(radian)
    -- �ʒu
    let x = 0.0
    let y = 0.0
    
    -- Heun�@
    heun 1 vx vy x y
