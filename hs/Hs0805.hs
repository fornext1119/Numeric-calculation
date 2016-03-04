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

-- Runge-Kutta-Gill�@
rungekuttagill::Integer->Double->Double->Double->Double->IO ()
rungekuttagill i vx vy x y =
    let 
        -- �o�ߕb��
        t = (fromIntegral i) * h

        -- �ʒu�E���x
        wx1  = h *     vx
        wy1  = h *     vy
        wvx1 = h * (fx vx vy)
        wvy1 = h * (fy vx vy)

        wvx5 = vx + wvx1 / 2.0
        wvy5 = vy + wvy1 / 2.0
        wx2  = h *     wvx5
        wy2  = h *     wvy5
        wvx2 = h * (fx wvx5 wvy5)
        wvy2 = h * (fy wvx5 wvy5)

        wvx6 = vx + wvx1 * ((sqrt(2.0) - 1.0) / 2.0) + wvx2 * (1.0 - 1.0 / sqrt(2.0))
        wvy6 = vy + wvy1 * ((sqrt(2.0) - 1.0) / 2.0) + wvy2 * (1.0 - 1.0 / sqrt(2.0))
        wx3  = h *     wvx6
        wy3  = h *     wvy6
        wvx3 = h * (fx wvx6 wvy6)
        wvy3 = h * (fy wvx6 wvy6)

        wvx7 = vx - wvx2 / sqrt(2.0) + wvx3 * (1.0 + 1.0 / sqrt(2.0))
        wvy7 = vy - wvy2 / sqrt(2.0) + wvy3 * (1.0 + 1.0 / sqrt(2.0))
        wx4  = h *     wvx7
        wy4  = h *     wvy7
        wvx4 = h * (fx wvx7 wvy7)
        wvy4 = h * (fy wvx7 wvy7)

        wx  = x  + ( wx1 +  wx2 * (2.0 - sqrt(2.0)) +  wx3 * (2.0 + sqrt(2.0)) +  wx4) / 6.0
        wy  = y  + ( wy1 +  wy2 * (2.0 - sqrt(2.0)) +  wy3 * (2.0 + sqrt(2.0)) +  wy4) / 6.0
        wvx = vx + (wvx1 + wvx2 * (2.0 - sqrt(2.0)) + wvx3 * (2.0 + sqrt(2.0)) + wvx4) / 6.0
        wvy = vy + (wvy1 + wvy2 * (2.0 - sqrt(2.0)) + wvy3 * (2.0 + sqrt(2.0)) + wvy4) / 6.0
    in
        if y >= 0.0
            then do
                printf "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n" t wvx wvy wx wy
                rungekuttagill (i+1) wvx wvy wx wy
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
    
    -- Runge-Kutta-Gill�@
    rungekuttagill 1 vx vy x y
