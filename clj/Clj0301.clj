; ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
(defn sn [a, lim]
    (def n (quot lim a))    ; €”:n  =  ãŒÀ:lim / Œö·:a
    (def l (* a   n))       ; ––€:l  =  €”:n   * Œö·:a
    (quot (* (+ a l) n) 2)) ; ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
; 3 ‚Ì”{”‚Ì‡Œv
(sn 3 999)
