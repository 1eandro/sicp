;;prerequisite definitions
(define (cube x)
  (* x x x))

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

;; fixed-point
(define (print x)
  (display x)
  (newline)
  x)

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess depth)
    (define (report-guess guess)
      (display depth)
      (display " *** ")
      (print guess))
    (let ((next (f (report-guess guess))))
      (if (close-enough? guess next)
          next
          (try next (inc depth)))))
  (try first-guess 1))

;; newthons-method
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define dx 0.00001)

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

;; cubic
(define (cubic a b c)
  (lambda (x)(+ (cube x) (* a (square x)) (* b x) c)))

;; zero
(define (zero a b c)
  (newtons-method (cubic a b c) 1))
