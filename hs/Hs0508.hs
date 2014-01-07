-- ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
mySinh::Double->Int->Double->Double->Double->Double
mySinh x n numerator denominator y =
let
    m     = 2 * n
    denom = denominator * (fromIntegral (m + 1)) * (fromIntegral m)
    num   = numerator   * x * x
    a     = num / denom
in 
    -- \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ğ”²‚¯‚é
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
    -- ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
    let x  = (fromIntegral i)
    let d1 = (mySinh x 1 x 1.0 x)
    -- •W€‚Ì‘o‹Èü³Œ·ŠÖ”
    let d2 = sinh(x)
    -- •W€ŠÖ”‚Æ‚Ì·ˆÙ
    printf "%3d : %17.10f - %17.10f = %13.10f\n" i d1 d2 (d1- d2)
