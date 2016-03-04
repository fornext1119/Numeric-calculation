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

-- ���_�@
midpoint::Integer->Double->Double->Double->Double->IO ()
midpoint i vx vy x y =
    let 
        -- �o�ߕb��
        t = (fromIntegral i) * h

        -- �ʒu�E���x
        wvx1 = h * (fx vx vy)
        wvy1 = h * (fy vx vy)
        wvx2 = vx + wvx1 / 2.0
        wvy2 = vy + wvy1 / 2.0

        wvx = vx + h * (fx wvx2 wvy2)
        wvy = vy + h * (fy wvx2 wvy2)
        wx  = x  + h *     wvx2
        wy  = y  + h *     wvy2
    in
        if y >= 0.0
            then do
                printf "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n" t wvx wvy wx wy
                midpoint (i+1) wvx wvy wx wy
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
    
    -- ���_�@
    midpoint 1 vx vy x y
