-- ����̋t���ڊ֐�
myAtan::Double->Double->Int->Double->Double
myAtan x x2 n t =
let
    m     = (fromIntegral (n `div` 2))
    denom = (m * m * x2) / ((fromIntegral n) + t)
    num   = n - 2
in 
    if num <= 1 then
        x / (1.0 + denom)
    else
        myAtan x x2 num denom

import Text.Printf
import Control.Monad

forM_ (
    map (\n -> n - 45) $ 
    map (* 15) $ 
    [0..6::Int]
) $ \degree -> do
    let radian = (fromIntegral degree) * pi / 180.0
    -- ����̋t���ڊ֐�
    let x2 = radian * radian
    let d1 = (myAtan radian x2 23 0.0) -- 23:�K�v�Ȑ��x��������\���傫�Ȋ
    -- �W���̋t���ڊ֐�
    let d2 = atan(radian)
    -- �W���֐��Ƃ̍���
    printf "%3d : %13.10f - %13.10f = %13.10f\n" degree d1 d2 (d1- d2)
