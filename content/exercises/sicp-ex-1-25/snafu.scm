(define (fast-expt b n)
  (cond ((= n 0) 1)
	((even? n) (square (fast-expt b (/ n 2))))
	(else (* b (fast-expt b (- n 1))))))

(define (expmod2 base exp m)
  (remainder (fast-expt base exp) m))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))

(define (beautify base exp m)
  (newline)
  (display base)
  (display "^")
  (display exp)
  (display " % ")
  (display m)
  (display " = "))

(define (report-expmod elasped-time new-expmod)
  (newline)
  (display "    ")
  (if new-expmod
      (display "new expmod *** ")
      (display "expmod *** "))
  (display elasped-time))

(define (start-expmod-test base exp m new-expmod startime)
  (if new-expmod
      (and (expmod2 base exp m) (report-expmod (- (runtime) startime) #t))
      (and (expmod base exp m)(report-expmod (- (runtime) startime) #f))))

(define (timed-test base exp m)
  (beautify base exp m)
  (display (expmod base exp m))
  (start-expmod-test base exp m #f (runtime))
  (start-expmod-test base exp m #t (runtime)))
