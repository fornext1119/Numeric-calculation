// “™·”—ñ‚ÌÏ
let rec product (m:int64) (d:int64) (n:int64) :int64 =
    match n with
        | 0L -> 1L
        | _  -> m * (product (m + d) d (n - 1L))
// ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ
product 5L 3L 10L
