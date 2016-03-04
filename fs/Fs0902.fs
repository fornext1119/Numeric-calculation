module Fs0902

open System

let f (x:double):double =
    x * x - 2.0

let rec falseposition (a:double) (b:double):double =
    // “_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ğŒ‹‚Ô’¼ü‚Æ x²‚ÌŒğ“_
    let c = (a * f(b) - b * f(a)) / (f(b) - f(a))
    printfn "%12.10f\t%13.10f" c (c - Math.Sqrt(2.0))

    let fc = f c
    if abs(fc) < 0.0000000001 then
        c
    else
        if fc < 0.0 then
            // f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
            falseposition c b
        else
            // f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
            falseposition a c

let a = 1.0
let b = 2.0
printfn "%12.10f" (falseposition a b)

exit 0
