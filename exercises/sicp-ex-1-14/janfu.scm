(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 3)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime-range cur-val count req)
  (cond ((not (= count req))
	  (if (fast-prime? cur-val 3)
	      (and (timed-prime-test cur-val)
	       (prime-range (+ cur-val 2)(+ count 1) req))
	      (prime-range (+ cur-val 2) count  req)))))

	  
(define (search-for-primes range no-of-primes)
  (prime-range (if (even? range)(- range 1) range) 0 no-of-primes))

