; ŠKæ
(defn Fact [n]
    (if (zero? n)
        1
        (* n (Fact (- n 1)))))
; ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
(def n 10)
(def r 5)
(quot (Fact n) (Fact (- n r)))
; ‰º~ŠKæ™p
(defn FallingFact [x n]
    (if (<= n 1)
        x
        (* x (FallingFact (- x 1) (- n 1)))))
; ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
(def n 10)
(def r 5)
(FallingFact n r)
