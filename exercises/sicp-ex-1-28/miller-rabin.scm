(define (fast-prime? n times)
  (cond ((= times 0) true)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (trivial-mod (check (expmod base (/ exp 2) m) base)
		    m))
	(else
	 (trivial-mod (* base (expmod base (- exp 1) m))
		    m))))

(define (trivial-mod num mod)
  (if (= num 0)
      0
      (remainder num mod)))

(define (check n num)
  (if (not-trivial? n num)
      0
      (square num )))

(define (not-trivial? n num)
  (if (and (= (square n)(remainder 1 n)) (not (and (= num 1)(= num (- n 1)))))
      #t
      #f))
