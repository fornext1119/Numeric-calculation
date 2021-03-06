; 階乗
(defn Fact [n]
    (if (zero? n)
        1
        (* n (Fact (- n 1)))))
; 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
(def n 10)
(def r 5)
(quot (Fact n) (Fact (- n r)))
; 下降階乗冪
(defn FallingFact [x n]
    (if (<= n 1)
        x
        (* x (FallingFact (- x 1) (- n 1)))))
; 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
(def n 10)
(def r 5)
(FallingFact n r)
