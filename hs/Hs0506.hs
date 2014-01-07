-- ����̑ΐ��֐�
myLog::Double->Double->Double->Double->Double;
myLog x2 numerator denominator y =
let
    denom = denominator + 2.0
    num   = numerator   * x2 * x2
    a     = num / denom
in 
    -- �\���Ȑ��x�ɂȂ����珈���𔲂���
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myLog x2 num denom a)
import Text.Printf
import Control.Monad

forM_ (
    map (\n -> (fromIntegral n) / 5.0) $ 
    [1..20::Int]
) $ \x -> do
    -- �W���̑ΐ��֐�
    let d1 = log(x)
    -- ����̑ΐ��֐�
    let x2 = (x - 1.0) / (x + 1.0)
    let d2 = 2.0 * (myLog x2 x2 1.0 x2)
    -- �W���֐��Ƃ̍���
    printf "%5.2f : %13.10f - %13.10f = %13.10f\n" x d1 d2 (d1- d2)
