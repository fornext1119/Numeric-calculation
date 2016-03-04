import Text.Printf
import Debug.Trace

f::Double->Double
f x = x * x - 2.0

secant::Double->Double->Double
secant x0 x1 =
    let
        x2 = x1 - (f x1) * (x1 - x0) / ((f x1) - (f x0))
    in
        if abs(x2 - x1) < 0.0000000001 then
            x2
        else
            trace (printf "%12.10f\t%13.10f" x2 (x2 - ((sqrt 2.0)::Double)))
            secant x1 x2

main = do
    let x0 = 1.0
    let x1 = 2.0
    printf "%12.10f\n" (secant x0 x1)
