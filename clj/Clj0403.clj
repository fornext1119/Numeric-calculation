; ŠKæ‚ğ‹‚ß‚éŠÖ”
(defn Fact [n]
    (if (zero? n)
        1
        (* n (Fact (- n 1)))))
; 10‚ÌŠKæ
(Fact 10)
