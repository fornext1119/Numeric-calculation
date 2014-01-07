-- ����̐����֐�
mySin::Double->Int->Bool->Double->Double->Double->Double
mySin x n nega numerator denominator y =
let
    m     = 2 * n
    denom = denominator * (fromIntegral (m + 1)) * (fromIntegral m)
    num   = numerator   * x * x
    a     = num / denom
in 
    -- �\���Ȑ��x�ɂȂ����珈���𔲂���
    if a <= 0.00000000001 then
        y
    else
        y + (mySin x (n + 1) (not nega) num denom (if nega then a else -a))
import Text.Printf
import Control.Monad

forM_ (
    filter (\n -> (mod n 30 == 0 || mod n 45 == 0)) $ 
    map (* 15) $ 
    [0..24::Int]
) $ \degree -> do
    let radian = (fromIntegral degree) * pi / 180.0
    -- ����̐����֐�
    let d1 = (mySin radian 1 False radian 1.0 radian)
    -- �W���̐����֐�
    let d2 = sin(radian)
    -- �W���֐��Ƃ̍���
    printf "%3d : %13.10f - %13.10f = %13.10f\n" degree d1 d2 (d1- d2)
