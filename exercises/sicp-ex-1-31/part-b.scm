(define (product-recur term a next b)
  (if (> a b)
      0
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a)(* result (term a)))))
  (iter a a))

