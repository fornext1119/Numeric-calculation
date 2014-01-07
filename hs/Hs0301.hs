-- ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
sn::Int->Int->Int
sn a lim =
    let
        n = lim `div` a      -- €”:n  =  ãŒÀ:lim / Œö·:a
        l = a * n            -- ––€:l  =  €”:n   * Œö·:a
    in
        (a + l) * n `div` 2  -- ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2

-- 3 ‚Ì”{”‚Ì‡Œv
main = putStrLn (show (sn 3 999))
