import Text.Printf
import Debug.Trace

f::Double->Double
f x = x * x - 2.0

falseposition::Double->Double->Double
falseposition a b =
    let
        -- “_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ğŒ‹‚Ô’¼ü‚Æ x²‚ÌŒğ“_
        c = (a * (f b) - b * (f a)) / ((f b) - (f a))
        fc = (f c) :: Double
    in
        if abs(fc) < 0.0000000001 then
            c
        else
            trace (printf "%12.10f\t%13.10f" c (c - ((sqrt 2.0)::Double))) $
            if fc < 0.0
                then
                    -- f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
                    falseposition c b
                else
                    -- f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
                    falseposition a c

main = do
    let a = 1.0
    let b = 2.0
    printf "%12.10f\n" (falseposition a b)
