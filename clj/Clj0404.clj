; ‰º~ŠKæ™p
(defn FallingFact [x n]
    (if (<= n 1)
        x
        (* x (FallingFact (- x 1) (- n 1)))))
; 10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
(FallingFact 10 5)
