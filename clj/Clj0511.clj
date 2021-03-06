;自作の逆正接関数
(defn myAtan [x x2 n t]
    (def m     (quot n 2))
    (def denom (/ (* (* m m) x2) (+ n t)))
    (def nume  (- n 2))
    (if (<= nume 1)
        (/ x (+ 1 denom))
        (myAtan x x2 nume denom)))

(doseq
    [degree (map #(- (* % 15) 45)
            (range 0 7))]
    (do (def radian (/ (* degree (. Math PI)) 180.0))
        (def x2     (* radian radian))
        ;自作の逆正接関数
        (def d1     (myAtan radian x2 23 0))
        ;標準の逆正接関数
        (def d2     (. Math atan radian))
        ;標準関数との差異
        (println (format "%3d : %13.10f - %13.10f = %13.10f" degree d1 d2 (- d1 d2)))))

-45 : -0.6657737500 - -0.6657737500 =  0.0000000000
-30 : -0.4823479071 - -0.4823479071 =  0.0000000000
-15 : -0.2560527700 - -0.2560527700 =  0.0000000000
  0 :  0.0000000000 -  0.0000000000 =  0.0000000000
 15 :  0.2560527700 -  0.2560527700 =  0.0000000000
 30 :  0.4823479071 -  0.4823479071 = -0.0000000000
 45 :  0.6657737500 -  0.6657737500 = -0.0000000000
nil



(doseq
    [i (map #(+ (* % 2) 1)
       (range 5 16))]
    (do (def radian 1)
        (def x2 (* radian radian))
        ;自作の逆正接関数
        (def d1 (myAtan radian x2 i 0))
        ;標準関数との差異
        (def pi (* d1 4.0))
        (println (format "%2d : %13.10f, %13.10f" i pi (- (pi (. Math PI))))))



11 :  3.1414634146, -0.0001292390
13 :  3.1416149068,  0.0000222532
15 :  3.1415888251, -0.0000038285
17 :  3.1415933119,  0.0000006583
19 :  3.1415925404, -0.0000001131
21 :  3.1415926730,  0.0000000194
23 :  3.1415926503, -0.0000000033
25 :  3.1415926542,  0.0000000006
27 :  3.1415926535, -0.0000000001
29 :  3.1415926536,  0.0000000000
31 :  3.1415926536, -0.0000000000
nil


