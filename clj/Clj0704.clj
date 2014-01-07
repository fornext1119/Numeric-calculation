(def N    7)
(def Nx2 14)

; 元の関数
(defn f[x]
    (+ (- x (/ (Math/pow x 3.0) (* 3 2))) (/ (Math/pow x 5.0) (* 5 (* 4 (* 3 2))))))

; 導関数
(defn fd[x]
    (+ (- 1.0 (/ (Math/pow x 2.0) 2)) (/ (Math/pow x 4.0) (* 4 (* 3 2)))))

; Hermite (エルミート) 補間
(defn hermite [d z a]
    (def sum_list (list (nth a 0)))
    (doseq [i (range 1 Nx2)]
        (def prod_list (list (nth a i)))
        (doseq [j (range 0 i)]
            (def prod_list (cons (- d (nth z j)) prod_list)))
        (def w (reduce * prod_list))
        (def sum_list (cons w sum_list)))
    (reduce + sum_list))

; 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
(def x  (map #(- (* % 1.5) 4.5) (range 0 N)))
(def y  (map #(f  %) x))
(def yd (map #(fd %) x))

; 差分商の表を作る
(def z (map #(nth x %) (map #(quot % 2) (range 0 Nx2))))
(def w (map #(nth y %) (map #(quot % 2) (range 0 Nx2))))
(def d (cons w nil))
(doseq [i (range 1 Nx2)]
    (def w (nth d 0))
    (def t (list))
    (doseq [j (range 0 (- Nx2 i))]
        (def t
            (cons
                (if (and (= i 1) (= (rem j 2) 0))
                    (nth yd (quot j 2))
	                (/ (- (nth w (+ j 1)) (nth w j))
	                   (- (nth z (+ j i)) (nth z j)))
				)
                t
            )
        )
    )
    (def d (cons (reverse t) d))
)
(def d (reverse d))

; ｎ階差分商
(def a (map #(nth (nth d %) 0) (range 0 Nx2)))

; 0.5刻みで 与えられていない値を補間
(def d1 (map #(- (* % 0.5) 4.5) (range 0 19)))
(def d2 (map #(f %) d1))
(def d3 (map #(hermite % z a) d1))

(doseq [d (map list d1 d2 d3)]
    (def d1 (nth d 0))
    (def d2 (nth d 1))
    (def d3 (nth d 2))
    (println (format "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (- d2 d3))))
