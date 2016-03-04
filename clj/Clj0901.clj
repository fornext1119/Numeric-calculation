(defn f[x]
    (- (* x x) 2.0))

(defn bisection [a b]
    ; ‹æŠÔ (a, b) ‚Ì’†“_ c = (a + b) / 2
    (def c (/ (+ a b) 2.0))
    (println (format "%12.10f\t%13.10f" c (- c (Math/sqrt 2))))

    (def fc (f c))
    (if (< (. Math abs fc) 0.00000000001)
        c
        (if (< fc 0)
            (bisection c b)
            (bisection a c))))

(def a 1.0)
(def b 2.0)
(println (format "%12.10f" (bisection a b)))
