(def N 4)

(def a [[-1.0 -2.0 7.0 -2.0] [1.0 -1.0 -2.0 6.0] [9.0 2.0 1.0 1.0] [2.0 8.0 -2.0 1.0]])
(def b  [8.0 17.0 20.0 16.0])

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

;各列で 一番値が大きい行を 探す
(defn get_max_row [row col a max_row max_val]
    ;一番値が大きい行
    (def ws1 
        (if (< max_val (. Math abs (nth (nth a row) col)))
            (vector row     (. Math abs (nth (nth a row) col)))
            (vector max_row max_val)))

    (def max_row2 (first  ws1))
    (def max_val2 (second ws1))
 
    (if (>= row (dec (count a)))
        (vector max_row2 max_val2)
        (get_max_row (inc row) col a max_row2 max_val2)))

;ピボット選択
(defn pivoting [pivot a b a2 b2]
    (def ws1 (get_max_row 0 pivot a 0 0.0))
    (def max_row (first  ws1))
    (def max_val (second ws1))

    (def a3 (cons (nth a max_row) a2))
    (def b3 (cons (nth b max_row) b2))
    (def a4 (concat (take max_row a) (drop (inc max_row) a)))
    (def b4 (concat (take max_row b) (drop (inc max_row) b)))

    (if (>= pivot (dec N))
        (vector (reverse a3) (reverse b3))
        (pivoting (inc pivot) a4 b4 a3 b3)))

;前進消去
(defn forward_elim_loop [pivot row a b]
    (def s (/ (nth (nth a row) pivot) (nth (nth a pivot) pivot)))

    (def a_map (map 
		(fn [a_piv a_row] (- a_row (* a_piv s))) 
			(drop pivot (nth a pivot)) (drop pivot (nth a row))))
    (def a1 (concat (take pivot (nth a row)) a_map))
    (def a2 (concat (take row   a)           (cons (vec a1) (drop (inc row) a))))

    (def x (- (nth b row) (* (nth b pivot) s)))
    (def b2 (concat (take row b) (cons x (drop (inc row) b))))
    (if (< row (dec N))
        (forward_elim_loop pivot (inc row) a2 b2)
        (vector a2 b2)))

(defn forward_elimination [pivot a b]
    (def ws1 
        (if (< pivot (dec N))
            (forward_elim_loop pivot (inc pivot) a b)
            (vector a b)))
    (def a2 (first ws1))
    (def b2 (second ws1))

    (if (< pivot (dec N))
        (forward_elimination (inc pivot) a2 b2)
        (vector a2 b2)))

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

;ピボット選択
(def ws1 (pivoting 0 a b [] []))
(def a1 (first ws1))
(def b1 (vec (second ws1)))

(println "pivoting")
(println "A")
(disp_matrix a1)
(println "B")
(disp_vector b1)
(println "")

;前進消去
(def ws2 (forward_elimination 0 a1 b1))
(def a2 (first ws2))
(def b2 (vec (second ws2)))

(println "forward elimination")
(println "A")
(disp_matrix a2)
(println "B")
(disp_vector b2)
(println "")

;後退代入
(def x (backward_substitution (dec N) a2 b2))

(println "X")
(disp_vector (reverse x))
