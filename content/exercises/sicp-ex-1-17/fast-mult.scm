(define (even? n)
  (= (remainder n 2) 0))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (fast-mult b n)
  (cond ((= n 0) 0)
	((even? n) (double (fast-mult b (halve n))))
	(else (+ b (fast-mult b (- n 1))))))
	
