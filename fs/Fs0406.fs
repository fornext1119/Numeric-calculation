// ŠKæ
let rec Fact = function
    |   0 -> 1
    |   n -> n * Fact(n - 1)
// ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂŽæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
let n = 10
let r = 5
Fact n / Fact (n - r)
// ‰º~ŠKæ™p
let rec FallingFact (x:int) (n:int):int =
    match n with
        | 1 -> x
        | _ -> x * (FallingFact (x - 1) (n - 1))
// ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂŽæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
let n = 10
let r = 5
FallingFact n r
