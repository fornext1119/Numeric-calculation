import Text.Printf
import Control.Monad

-- データ点の数 - 1
n = 6 :: Int

-- 元の関数
f::Double->Double
f x = x - (x ^ 3) / (fromIntegral (3 * 2)) + (x ^ 5) / (fromIntegral (5 * 4 * 3 * 2))

-- ３項方程式を解く (ト－マス法)
thomas::Int->[Double]->[Double]->[Double]->[Double]->[Double]->[Double]->([Double], [Double])
thomas i a b c d gs ss =
    let
        g = b!!i - a!!i * c!!(i-1) / gs!!0
        s = d!!i - a!!i * ss!!0    / gs!!0
    in
        if i == (n - 1) then (reverse (g:gs), reverse (s:ss))
                        else (thomas (i + 1) a b c d (g:gs) (s:ss))

thomas2::Int->[Double]->[Double]->[Double]->[Double]->[Double]
thomas2 i g s c zs =
    let
        z = (s!!i - c!!i * zs!!0) / g!!i
    in
        if i == 1 then 0.0 : z : zs
                  else thomas2 (i - 1) g s c (z:zs)

-- Spline (スプライン) 補間
spline::Double->[Double]->[Double]->[Double]->Double
spline d x y z =
    let
        -- 補間関数値がどの区間にあるか
        k = if d <= x!!0 then 0
                        else (length $ filter (\i -> i < d) $ x) - 1
 
        d1 = x!!(k+1) - d
        d2 = d        - x!!k
        d3 = x!!(k+1) - x!!k
    in
        (z!!k * (d1 ^ 3) + z!!(k+1) * (d2 ^ 3)) / (6.0 * d3) +
        (y!!k     / d3 - z!!k     * d3 / 6.0) * d1 +
        (y!!(k+1) / d3 - z!!(k+1) * d3 / 6.0) * d2


main = do
    -- 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    let x = map(\i -> (fromIntegral i) * 1.5 - 4.5) [0..n]
    let y = map(\i -> f(i)) x
    
    -- ３項方程式の係数の表を作る
    let a = 0.0 : map(\i ->       x!!i      - x!!(i-1))  [1..n - 1]
    let b = 0.0 : map(\i -> 2 *  (x!!(i+1)  - x!!(i-1))) [1..n - 1]
    let c = 0.0 : map(\i ->       x!!(i+1)  - x!!i)      [1..n - 1]
    let d = 0.0 : map(\i -> 6 *  ((y!!(i+1) - y!!i) / (x!!(i+1) - x!!i) - (y!!i - y!!(i-1)) / (x!!i - x!!(i-1)))) [1..n - 1]

    -- ３項方程式を解く (ト－マス法)
    let (g, s) = (thomas 2 a b c d [b!!1, 0.0] [d!!1, 0.0])
    let z      = (thomas2 (n - 2) g s c [s!!(n-1) / g!!(n-1), 0.0])
    
    -- 0.5刻みで 与えられていない値を補間
    let d1 = map(\i -> (fromIntegral i) * 0.5 - 4.5) [0..18]
    let d2 = map(\i -> (f i)) d1
    let d3 = map(\i -> (spline i x y z)) d1

    forM_ (zip (zip d1 d2) d3) $ \((d1, d2), d3) -> do
        printf "%5.2f\t%8.5f\t%8.5f\t%8.5f\n" d1 d2 d3 (d2 - d3)
