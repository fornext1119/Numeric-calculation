import Text.Printf

-- 重力加速度
g = -9.8 :: Double
-- 空気抵抗係数
k = -0.01 :: Double
-- 時間間隔(秒)
h = 0.01 :: Double

-- 空気抵抗による水平方向の減速分
fx::Double->Double->Double
fx vx vy = 
    let
        v = sqrt(vx * vx + vy * vy)
    in
        k * v * vx
    
-- 空気抵抗による鉛直方向の減速分
fy::Double->Double->Double
fy vx vy = 
    let
        v = sqrt(vx * vx + vy * vy)
    in
        g + (k * v * vy)

-- 中点法
midpoint::Integer->Double->Double->Double->Double->IO ()
midpoint i vx vy x y =
    let 
        -- 経過秒数
        t = (fromIntegral i) * h

        -- 位置・速度
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
    -- 角度
    let degree = 45.0 :: Double
    let radian = degree * pi / 180.0
    -- 初速 250 km/h -> 秒速に変換
    let v = (fromIntegral (250 * 1000 `div` 3600))

    -- 水平方向の速度
    let vx = v * cos(radian)
    -- 鉛直方向の速度
    let vy = v * sin(radian)
    -- 位置
    let x = 0.0
    let y = 0.0
    
    -- 中点法
    midpoint 1 vx vy x y
