(range 0 10)
(map 
    #(+ 5 (* 3 %))
    (range 0 10))
(apply *
    (map 
        #(+ 5 (* 3 %))
        (range 0 10)))
