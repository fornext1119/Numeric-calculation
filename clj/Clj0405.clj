; �㏸�K��p
(defn RisingFact [x n]
    (if (<= n 1)
        x
        (* x (RisingFact (+ x 1) (- n 1)))))
; 10 ���� 14 �܂ł� ����
(RisingFact 10 5)
