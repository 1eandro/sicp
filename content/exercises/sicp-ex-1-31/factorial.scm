(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (id x) x)
(define (inc x)(+ x 1))

(define (factorial x)
  (product id 1 inc x))

