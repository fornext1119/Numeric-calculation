(def N 7)

; 元の関数
(defn f[x]
    (+ (- x (/ (Math/pow x 3.0) (* 3 2))) (/ (Math/pow x 5.0) (* 5 (* 4 (* 3 2))))))

; Spline (スプライン) 補間
(defn spline [d x y z]
    ; 補間関数値がどの区間にあるか
    (def k -1)
    (doseq [i (range 1 N)]
        (if (and (<= d (nth x i)) (< k 0))
            (def k (- i 1))
        )
    )
    (if (< k 0) (def k N))

    (def d1 (- (nth x (+ k 1)) d))
    (def d2 (- d               (nth x k)))
    (def d3 (- (nth x (+ k 1)) (nth x k)))

    (def a1 (*  (nth z k)       (Math/pow d1 3.0)))
    (def a2 (*  (nth z (+ k 1)) (Math/pow d2 3.0)))
    (def a3 (/ (+ a1 a2) (* 6.0 d3)))

    (def b1 (/ (nth y k) d3))
    (def b2 (* (nth z k) d3))
    (def b3 (/ b2 6.0))
    (def b4 (* (- b1 b3) d1))

    (def c1 (/ (nth y (+ k 1)) d3))
    (def c2 (* (nth z (+ k 1)) d3))
    (def c3 (/ c2 6.0))
    (def c4 (* (- c1 c3) d2))
    
    (+ (+ a3 b4) c4)
)

; 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
(def x (map #(- (* % 1.5) 4.5) (range 0 N)))
(def y (map #(f %) x))

; ３項方程式の係数の表を作る
(def a (list 0.0))
(def b (list 0.0))
(def c (list 0.0))
(def d (list 0.0))
(doseq [i (range 1 (- N 1))]
    (def a (cons          (- (nth x i      ) (nth x (- i 1)))  a))
    (def b (cons  (* 2.0  (- (nth x (+ i 1)) (nth x (- i 1)))) b))
    (def c (cons          (- (nth x (+ i 1)) (nth x i      ))  c)) 
    (def d (cons  (* 6.0  (- (/ (- (nth y(+ i 1)) (nth y i)) 
                                (- (nth x(+ i 1)) (nth x i))) 
                            (/  (- (nth y i)      (nth y (- i 1))) 
                                (- (nth x i)      (nth x (- i 1)))))) d)))
(def a (reverse a))
(def b (reverse b))
(def c (reverse c))
(def d (reverse d))

; ３項方程式を解く (ト－マス法)
(def g (list (nth b 1) 0.0))
(def s (list (nth d 1) 0.0))
(doseq [i (range 2 (- N 1))]
    (def w (nth g 0))
    (def g (cons    (-  (nth b i) 
                        (/  (*  (nth a i) 
                                (nth c (- i 1))) 
                            w)) 
                    g))
    (def s (cons    (-  (nth d i) 
                        (/  (*  (nth a i) 
                                (nth s 0)) 
                            w)) 
                    s))
)
(def g (reverse g))
(def s (reverse s))

(def z (list 0.0))
(def z (cons (/ (nth s (- N 2)) (nth g (- N 2))) z))
(doseq [i (reverse (range 1 (- N 2)))]
    (def z (cons    (/  (-  (nth s i)
                            (* (nth c i) (nth z 0)))
                        (nth g i))
                    z))
)
(def z (cons 0.0 z))

; 0.5刻みで 与えられていない値を補間
(def d1 (map #(- (* % 0.5) 4.5) (range 0 19)))
(def d2 (map #(f %) d1))
(def d3 (map #(spline % x y z) d1))

(doseq [d (map list d1 d2 d3)]
    (def d1 (nth d 0))
    (def d2 (nth d 1))
    (def d3 (nth d 2))
    (println (format "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (- d2 d3))))
