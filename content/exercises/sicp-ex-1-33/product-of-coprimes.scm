(define (filtre-accumulate filtre combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (if (filtre a)
		    (term a)
		    null-value)
		(filtre-accumulate filtre combiner null-value term (next a) next b))))

(define (id a )
  a) ;; identity

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product-of-coprimes b)
  (define (coprime? a)
    (= (gcd a b) 1))
  (filtre-accumulate coprime? * 1 id 1 inc b))
