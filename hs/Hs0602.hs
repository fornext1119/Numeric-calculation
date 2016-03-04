import Text.Printf
import Control.Monad

f::Double->Double
f x = 4 / (1 + (x * x))

main = do 
    forM_ ([1..10::Integer]) $ \j -> do
        let n = 2 ^ j
        let a = 0.0
        let b = 1.0
        let h = (b - a) / (fromIntegral n)
        -- ���_���Őϕ�
        let a2 = a + (h / 2)
        let w1 = sum $ map(\x -> f x) $ map(\i -> (fromIntegral i) * h + a2) $ [0..(n-1)]
        let t1 = h * w1
        -- ���ʂ� �� �Ɣ�r
        let t2 = t1 - pi
        printf "%3d : %13.10f, %13.10f\n" j t1 t2
