(define (fast-mult b n)
  (mult-iter b 0 n b))

(define (mult-iter a b n base)
  (cond ((= n 1)
	 (+ a b))
	((even? n)
	 (mult-iter (double a) b (halve n) base))
	(else (mult-iter a (+ b base) (- n 1) base))))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))
