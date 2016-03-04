-- ����̎w���֐�
myExp::Double->Int->Double->Double->Double->Double
myExp x n numerator denominator y =
let
    denom = denominator * (fromIntegral n)
    num   = numerator   * x
    a     = num / denom
in 
    -- �\���Ȑ��x�ɂȂ����珈���𔲂���
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myExp x (n + 1) num denom a)
import Text.Printf
import Control.Monad

forM_ (
    map (\n -> (fromIntegral (n - 10)) / 4.0) $ 
    [0..20::Int]
) $ \x -> do
    -- �W���̎w���֐�
    let d1 = exp(x)
    -- ����̎w���֐�
    let d2 = (myExp x 1 1.0 1.0 1.0)
    -- �W���֐��Ƃ̍���
    printf "%5.2f : %13.10f - %13.10f = %13.10f\n" x d1 d2 (d1- d2)
