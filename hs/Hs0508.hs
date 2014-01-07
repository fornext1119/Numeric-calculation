-- ����̑o�Ȑ������֐�
mySinh::Double->Int->Double->Double->Double->Double
mySinh x n numerator denominator y =
let
    m     = 2 * n
    denom = denominator * (fromIntegral (m + 1)) * (fromIntegral m)
    num   = numerator   * x * x
    a     = num / denom
in 
    -- �\���Ȑ��x�ɂȂ����珈���𔲂���
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (mySinh x (n + 1) num denom a)
import Text.Printf
import Control.Monad

forM_ (
    map ((-) 10) $ 
    [0..20::Int]
) $ \i -> do
    -- ����̑o�Ȑ������֐�
    let x  = (fromIntegral i)
    let d1 = (mySinh x 1 x 1.0 x)
    -- �W���̑o�Ȑ������֐�
    let d2 = sinh(x)
    -- �W���֐��Ƃ̍���
    printf "%3d : %17.10f - %17.10f = %13.10f\n" i d1 d2 (d1- d2)
