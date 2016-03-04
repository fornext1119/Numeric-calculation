(defn f[x]
    (- (* x x) 2.0))

(defn secant [x0 x1]
    (def x2 (- x1 
               (/ (* (f x1) (- x1 x0))
                  (- (f x1) (f x0)))))
    (println (format "%12.10f\t%13.10f" x2 (- x2 (Math/sqrt 2))))

    (if (< (. Math abs (- x2 x1)) 0.00000000001)
        x2
        (secant x1 x2)))

(def x0 1.0)
(def x1 2.0)
(println (format "%12.10f" (secant x0 x1)))
