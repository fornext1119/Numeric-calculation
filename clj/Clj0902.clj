(defn f[x]
    (- (* x x) 2.0))

(defn falseposition [a b]
    ; “_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ğŒ‹‚Ô’¼ü‚Æ x²‚ÌŒğ“_
    (def c (/ (- (* a (f b)) (* b (f a))) (- (f b) (f a))))
    (println (format "%12.10f\t%13.10f" c (- c (Math/sqrt 2))))

    (def fc (f c))
    (if (< (. Math abs fc) 0.00000000001)
        c
        (if (< fc 0)
            (falseposition c b)
            (falseposition a c))))

(def a 1.0)
(def b 2.0)
(println (format "%12.10f" (falseposition a b)))
