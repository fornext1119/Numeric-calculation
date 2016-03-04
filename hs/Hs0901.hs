import Text.Printf
import Debug.Trace

f::Double->Double
f x = x * x - 2.0

bisection::Double->Double->Double
bisection a b =
    let
        -- ‹æŠÔ (a, b) ‚Ì’†“_ c = (a + b) / 2
        c = (a + b) / 2.0
        fc = (f c) :: Double
    in
        if abs(fc) < 0.0000000001 then
            c
        else
            trace (printf "%12.10f\t%13.10f" c (c - ((sqrt 2.0)::Double))) $
            if fc < 0.0
                then
                    -- f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
                    bisection c b
                else
                    -- f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
                    bisection a c

main = do
    let a = 1.0
    let b = 2.0
    printf "%12.10f\n" (bisection a b)
