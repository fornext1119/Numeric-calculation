// è„è∏äKèÊôp
let rec RisingFact (x:int) (n:int):int =
    match n with
        | 1 -> x
        | _ -> x * (RisingFact (x + 1) (n - 1))
// 10 Ç©ÇÁ 14 Ç‹Ç≈ÇÃ ëçèÊ
RisingFact 10 5
