(def N 4)

(def a [[5.0 2.0 3.0 4.0] [2.0 10.0 6.0 7.0] [3.0 6.0 15.0 9.0] [4.0 7.0 9.0 20.0]])
(def b  [34.0 68.0 96.0 125.0])

;１次元配列を表示
(defn disp_vector [row]
    (doseq [col row]
        (print (format "%14.10f\t" col)))
    (println))

;２次元配列を表示
(defn disp_matrix [matrix]
    (doseq [row matrix]
        (doseq [col row]
            (print (format "%14.10f\t" col)))
        (println)))

;前進消去
(defn forward_elim_loop [pivot row a a_sqrt]
    (def a_map (map 
        (fn [a_row a_piv] (* a_row a_piv)) 
            (take pivot (nth a row)) (take pivot (nth a pivot))))
    (def s (apply + a_map))
    (def a_col (/ (- (nth (nth a row) pivot) s) a_sqrt))

    (def a_row (concat (take pivot (nth a row  )) (cons a_col (drop (inc pivot) (nth a row)))))
    (def a_piv (concat (take row   (nth a pivot)) (cons a_col (drop (inc row)   (nth a pivot)))))

    (def a1 (concat (take pivot a ) (cons (vec a_piv) (drop (inc pivot) a))))
    (def a2 (concat (take row   a1) (cons (vec a_row) (drop (inc row)   a))))

    (if (< row (dec N))
        (forward_elim_loop pivot (inc row) a2 a_sqrt)
        a2))

(defn forward_elimination [pivot a]
    (def a_map (map (fn [col] (* col col)) (take pivot (nth a pivot))))
    (def s (apply + a_map))

    ;ここで根号の中が負の値になると計算できない！
    (def a_sqrt (. Math sqrt (- (nth (nth a pivot) pivot) s)))
    (def a2 (forward_elim_loop pivot pivot a a_sqrt))

    (if (< pivot (dec N))
        (forward_elimination (inc pivot) a2)
        a2))

;前進代入
(defn forward_substitution [row a b]
    (def a_map (map 
        (fn [a_col b_col] (* a_col b_col)) 
            (take row (nth a row)) b))
    (def s (apply + a_map))
    (def y (/ (- (nth b row) s) (nth (nth a row) row)))
    (def b2 (concat (take row b) (cons y (drop (inc row) b))))
    (if (< row (dec N))
        (cons y (forward_substitution (inc row) a b2))
        (cons y [])))

;後退代入
(defn backward_substitution [row a b]
    (def a_map (map 
        (fn [a_col b_col] (* a_col b_col)) 
            (drop (inc row) (nth a row)) (drop (inc row) b)))
    (def s (apply + a_map))
    (def x (/ (- (nth b row) s) (nth (nth a row) row)))
    (def b2 (concat (take row b) (cons x (drop (inc row) b))))
    (if (> row 0)
        (cons x (backward_substitution (dec row) a b2))
        (cons x [])))

(println "A")
(disp_matrix a)
(println "B")
(disp_vector b)
(println "")

;前進消去
(def a2 (forward_elimination 0 a))

(println "LL^T")
(disp_matrix a2)

;Ly=b から y を求める (前進代入)
(def y (forward_substitution 0 a2 b))

(println "Y")
(disp_vector y)

;L^Tx=y から x を求める (後退代入)
(def x (backward_substitution (dec N) a2 y))

(println "X")
(disp_vector (reverse x))
