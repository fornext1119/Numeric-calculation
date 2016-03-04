; ‘g‡‚¹
(defn Comb [n r]
    (cond (or (= r 0) (= r n)) 1
          (= r 1)              n
          true                 (+ (Comb (- n 1) (- r 1)) (Comb (- n 1) r))))
; ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚çd•¡‚ğ‹–‚µ‚Ä 5 ŒÂæ‚é‘g‡‚¹‚Ì‘”
(def n 10)
(def r 5)
(Comb (+ n (- r 1)) r)
