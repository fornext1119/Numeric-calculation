import Text.Printf
import Debug.Trace

f0::Double->Double
f0 x = x * x - 2.0

f1::Double->Double
f1 x = 2.0 * x

f2::Double->Double
f2 x = 2.0

bailey::Double->Double
bailey x0 =
    let
        x1 = x0 - ((f0 x0) / ((f1 x0) - ((f0 x0) * (f2 x0) / (2.0 * (f1 x0)))))
    in
        if abs(x1 - x0) < 0.0000000001 then
            x1
        else
            trace (printf "%12.10f\t%13.10f" x1 (x1 - ((sqrt 2.0)::Double)))
            bailey x1

main = do
    let x = 2.0
    printf "%12.10f\n" (bailey x)
