(define (f n)
  (if (< n 3)
      n
      (f-iter 2 1 0 (- n 3))))

(define (f-iter a b c n)
  (if (= count 0)
      (+ a
         (* 2 b)
         (* 3 c))
      (f-iter (+ a (* b 2) (* c 3))
              a b (- n 1))))
