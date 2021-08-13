(define (fast-expt b n)
  (expt-iter b n 1 b))


(define (expt-iter b n a base)
  (cond ((= n 1) (* a b))
        ((not (even? n)) (expt-iter b (- n 1) (* a base) base))
        (else (expt-iter (square b) (/ n 2) a base))))


(define (even? n)
  (= (remainder n 2) 0))
