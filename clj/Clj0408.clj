; �g����
(defn Comb [n r]
    (cond (or (= r 0) (= r n)) 1
          (= r 1)              n
          true                 (+ (Comb (- n 1) (- r 1)) (Comb (- n 1) r))))
; �قȂ� 10 �̂��̂��� 5 ����Ăł���g�����̑���
(def n 10)
(def r 5)
(Comb n r)
