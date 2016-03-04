-- ����̎w���֐�
myExp::Double->Double->Int->Double->Double;
myExp x x2 n t =
let
    denom = x2 / ((fromIntegral n) + t)
    num   = n - 4
in 
    if num < 6 then
        1.0 + ((2.0 * x) / (2.0 - x + denom))
    else
        myExp x x2 num denom
import Text.Printf
import Control.Monad

forM_ (
    map (\n -> (fromIntegral (n - 10)) / 4.0) $ 
    [0..20::Int]
) $ \x -> do
    -- �W���̎w���֐�
    let d1 = exp(x)
    -- ����̎w���֐�
    let x2 = x * x
    let d2 = (myExp x x2 30 0.0) -- 30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
    -- �W���֐��Ƃ̍���
    printf "%5.2f : %13.10f - %13.10f = %13.10f\n" x d1 d2 (d1- d2)
