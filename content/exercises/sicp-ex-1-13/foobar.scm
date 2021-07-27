(define (next input)
  (if (= input 2)
      3
      (+ input 2)))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))
  
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime-range cur-val count req)
  (cond ((not (= count req))
	  (if (prime? cur-val)
	      (and (timed-prime-test cur-val)
	       (prime-range (+ cur-val 2)(+ count 1) req))
	      (prime-range (+ cur-val 2) count  req)))))

	  
(define (search-for-primes range no-of-primes)
  (prime-range (if (even? range)(- range 1) range) 0 no-of-primes))
