import Text.Printf
import Debug.Trace

g::Double->Double
g x = (x / 2.0) + (1.0 / x)

iterative::Double->Double
iterative x0 =
    let
        x1 = (g x0)
    in
        if abs(x1 - x0) < 0.0000000001 then
            x1
        else
            trace (printf "%12.10f\t%13.10f" x1 (x1 - ((sqrt 2.0)::Double)))
            iterative x1

main = do
    let x = 1.0
    printf "%12.10f\n" (iterative x)
