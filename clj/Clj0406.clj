; �K��
(defn Fact [n]
    (if (zero? n)
        1
        (* n (Fact (- n 1)))))
; ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
(def n 10)
(def r 5)
(quot (Fact n) (Fact (- n r)))
; ���~�K��p
(defn FallingFact [x n]
    (if (<= n 1)
        x
        (* x (FallingFact (- x 1) (- n 1)))))
; ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
(def n 10)
(def r 5)
(FallingFact n r)
