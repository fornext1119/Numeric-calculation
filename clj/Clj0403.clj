; �K������߂�֐�
(defn Fact [n]
    (if (zero? n)
        1
        (* n (Fact (- n 1)))))
; 10�̊K��
(Fact 10)
