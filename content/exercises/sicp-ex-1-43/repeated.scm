(define (compose f g)
  (lambda (x) (f (g x))))

(define (double f)
  (compose f f))

(define (inc x)
  (+ x 1))

(define (square x)
  (* x x))

(define (repeated f n)
  (repeated-recur f n))

(define (repeated-recur f n)
  ((cond ((= n 1)(lambda (x)(f x)))
         ((even? n)(double (repeated-recur f (/ n 2))))
         ((odd? n)(compose f (repeated-recur f (- n 1))))
         (else (lambda (x)(x))))))

(define (r f n)
  (rep-iter f n))

(define (rep-iter f n)
  (if (= n 1)
      (lambda (x) (f x))
      (compose (lambda (x) (f x)) (rep-iter f (- n 1)))))
