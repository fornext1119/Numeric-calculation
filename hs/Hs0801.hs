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

-- Euler法
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
    
    -- Euler法
    euler 1 vx vy x y
