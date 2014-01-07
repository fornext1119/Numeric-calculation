(def N 7)

; ���̊֐�
(defn f[x]
    (+ (- x (/ (Math/pow x 3.0) (* 3 2))) (/ (Math/pow x 5.0) (* 5 (* 4 (* 3 2))))))

; Lagrange (���O�����W��) ���
(defn lagrange [d x y]
    (def sum_list (list 0.0))
    (doseq [i (range 0 N)]
        (def prod_list (list (nth y i)))
        (doseq [j (range 0 N)]
            (if (= i j)
                (def prod_list (cons 1 prod_list))
                (do (def w1 (/ (- d (nth x j)) (- (nth x i) (nth x j))))
                    (def prod_list (cons w1 prod_list)))))
        (def w2 (reduce * prod_list))
        (def sum_list (cons w2 sum_list)))
    (reduce + sum_list))

; 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
(def x (map #(- (* % 1.5) 4.5) (range 0 N)))
(def y (map #(f %) x))

; 0.5���݂� �^�����Ă��Ȃ��l����
(def d1 (map #(- (* % 0.5) 4.5) (range 0 19)))
(def d2 (map #(f %) d1))
(def d3 (map #(lagrange % x y) d1))

(doseq [d (map list d1 d2 d3)]
    (def d1 (nth d 0))
    (def d2 (nth d 1))
    (def d3 (nth d 2))
    (println (format "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (- d2 d3))))
