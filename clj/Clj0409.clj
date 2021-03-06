; 組合せ
(defn Comb [n r]
    (cond (or (= r 0) (= r n)) 1
          (= r 1)              n
          true                 (+ (Comb (- n 1) (- r 1)) (Comb (- n 1) r))))
; 異なる 10 個のものから重複を許して 5 個取る組合せの総数
(def n 10)
(def r 5)
(Comb (+ n (- r 1)) r)
