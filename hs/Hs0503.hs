-- ����̐��ڊ֐�
myTan::Double->Double->Int->Double->Double
myTan x x2 n t =
let
    denom = x2 / ((fromIntegral n) - t)
    num   = n - 2
in 
    if num <= 1 then
        x / (1.0 - denom)
    else
        myTan x x2 num denom
import Text.Printf
import Control.Monad

forM_ (
    map    (\n -> n - 90) $ 
    filter (\n -> mod n 180 /= 0) $ 
    map    (* 15) $ 
    [0..12::Int]
) $ \degree -> do
    let radian = (fromIntegral degree) * pi / 180.0
    -- ����̐��ڊ֐�
    let x2 = radian * radian
    let d1 = (myTan radian x2 15 0.0) -- 15:�K�v�Ȑ��x��������\���傫�Ȋ
    -- �W���̐��ڊ֐�
    let d2 = tan(radian)
    -- �W���֐��Ƃ̍���
    printf "%3d : %13.10f - %13.10f = %13.10f\n" degree d1 d2 (d1- d2)
