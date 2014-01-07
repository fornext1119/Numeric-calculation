-- ����̑o�Ȑ��]���֐�
myCosh::Double->Int->Double->Double->Double->Double;
myCosh x n numerator denominator y =
let
    m     = 2 * n
    denom = denominator * (fromIntegral m) * (fromIntegral (m - 1))
    num   = numerator   * x * x
    a     = num / denom
in 
    -- �\���Ȑ��x�ɂȂ����珈���𔲂���
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myCosh x (n + 1) num denom a)
import Text.Printf
import Control.Monad

forM_ (
    map ((-) 10) $ 
    [0..20::Int]
) $ \i -> do
    -- ����̑o�Ȑ��]���֐�
    let x  = (fromIntegral i)
    let d1 = (myCosh x 1 1.0 1.0 1.0)
    -- �W���̑o�Ȑ��]���֐�
    let d2 = cosh(x)
    -- �W���֐��Ƃ̍���
    printf "%3d : %17.10f - %17.10f = %13.10f\n" i d1 d2 (d1- d2)
