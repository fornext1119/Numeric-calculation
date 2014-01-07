-- ����̑ΐ��֐�
myLog::Double->Int->Double->Double
myLog x n t =
let 
    n2 = if rem n 2 == 0 then 2
                         else n
    n3 = if n > 3        then n2
                         else n
    x2 = if n > 3        then x * (fromIntegral (div n 2))
                         else x
    t2 = x2 / ((fromIntegral n3) + t)
in
    if n <= 2            then x / (1.0 + t2)
                         else myLog x (n - 1) t2
import Text.Printf
import Control.Monad

forM_ (
    map (\n -> (fromIntegral n) / 5.0) $ 
    [1..20::Int]
) $ \x -> do
    -- �W���̑ΐ��֐�
    let d1 = log(x)
    -- ����̑ΐ��֐�
    let d2 = (myLog (x - 1.0) 27 0.0) -- 27:�K�v�Ȑ��x��������\���傫�Ȋ
    -- �W���֐��Ƃ̍���
    printf "%5.2f : %13.10f - %13.10f = %13.10f\n" x d1 d2 (d1- d2)
