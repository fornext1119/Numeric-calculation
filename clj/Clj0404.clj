; ���~�K��p
(defn FallingFact [x n]
    (if (<= n 1)
        x
        (* x (FallingFact (- x 1) (- n 1)))))
; 10 ���� 6 �܂ł� ����
(FallingFact 10 5)
