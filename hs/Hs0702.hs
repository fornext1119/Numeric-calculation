import Text.Printf
import Control.Monad

-- データ点の数 - 1
n = 6 :: Int

-- 元の関数
f::Double->Double
f x = x - (x ^ 3) / (fromIntegral (3 * 2)) + (x ^ 5) / (fromIntegral (5 * 4 * 3 * 2))

-- Neville (ネヴィル) 補間
neville::Double->[Double]->[Double]->Int->Double
neville d x w j =
    let 
        t = map(\i -> do
                (w!!(i+1) + (w!!(i+1) - w!!i) * (d - x!!(i+j)) / (x!!(i+j) - x!!i))
            ) [0..(n-j)::Int]
    in
        if j == n then t!!0
                  else (neville d x t (j + 1))

main = do
    -- 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    let x = map(\i -> (fromIntegral i) * 1.5 - 4.5) [0..n]
    let y = map(\i -> f(i)) x

    -- 0.5刻みで 与えられていない値を補間
    let d1 = map(\i -> (fromIntegral i) * 0.5 - 4.5) [0..18]
    let d2 = map(\i -> (f i)) d1
    let d3 = map(\i -> (neville i x y 1)) d1

    forM_ (zip (zip d1 d2) d3) $ \((d1, d2), d3) -> do
        printf "%5.2f\t%8.5f\t%8.5f\t%8.5f\n" d1 d2 d3 (d2 - d3)
