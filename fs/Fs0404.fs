// â∫ç~äKèÊôp
let rec FallingFact (x:int) (n:int):int =
    match n with
        | 1 -> x
        | _ -> x * (FallingFact (x - 1) (n - 1))
// 10 Ç©ÇÁ 6 Ç‹Ç≈ÇÃ ëçèÊ
FallingFact 10 5
