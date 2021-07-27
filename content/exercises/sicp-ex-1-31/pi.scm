(define (inc x)(+ x 2))
(define (id x) x)
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-range a b)
  (product id a inc b))

(define (fact-range a b)
  (if (or (and (even? a)(even? b))(and (odd? a)(odd? b)))
      (product-range a b)
      (product-range (+ a 1) b)))

(define(pi n)
  (* (square (/ (fact-range 4 (- n 2))
	      (fact-range 3 (- n 1))))
	8.0
	(if (even? n)
	    n
	    (+ n 1.0))))
