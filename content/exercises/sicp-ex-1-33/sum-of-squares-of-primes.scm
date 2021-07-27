;; some prerequisites

(define (inc x)(+ x 1))
(define (square x)(* x x))

(define (filtre-accumulate filtre combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (if (filtre a)
		    (term a)
		    null-value)
		(filtre-accumulate filtre combiner null-value term (next a) next b))))

;; functions for prime?

(define (prime? n)
   (define (smallest-divisor n)
      (define (find-divisor n test-divisor)
         (define (next x)
            (if (= x 2) 3 (+ x 2)))
         (define (divides? a b)
            (= (remainder b a) 0))
         (cond ((> (square test-divisor) n) n)
               ((divides? test-divisor n) test-divisor)
               (else (find-divisor n (next test-divisor)))))
      (find-divisor n 2))
   (= n (smallest-divisor n)))

;; sum-of-squares-of-primes

(define (sum-of-squares-of-primes a b)
  (filtre-accumulate prime? + 0 square a inc b))
