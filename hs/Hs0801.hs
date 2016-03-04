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

-- Euler�@
euler::Integer->Double->Double->Double->Double->IO ()
euler i vx vy x y =
    let 
        t = (fromIntegral i) * h
        wx = x + h * vx
        wy = y + h * vy
        wvx = vx + h * (fx vx vy)
        wvy = vy + h * (fy vx vy)
    in
        if y >= 0.0
            then do
                printf "%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n" t vx vy wx wy
                euler (i+1) wvx wvy wx wy
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
    
    -- Euler�@
    euler 1 vx vy x y
