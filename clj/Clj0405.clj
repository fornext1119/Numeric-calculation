; ã¸ŠKæ™p
(defn RisingFact [x n]
    (if (<= n 1)
        x
        (* x (RisingFact (+ x 1) (- n 1)))))
; 10 ‚©‚ç 14 ‚Ü‚Å‚Ì ‘æ
(RisingFact 10 5)
