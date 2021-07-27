(define (improve-guess guess x )
  (/ (+ (* 2 guess ) (/ x (square guess))) 3));; New improve-guess


(define (square x)
  (* x x));; returns the square of a numeral


(define (good-enough? guess x)
  (< (abs(/ (- (improve-guess guess x) guess) guess)) 0.0001))


(define (curt-iter guess x)
  (if (good-enough? guess x)
      guess
      (curt-iter (improve-guess guess x)
                 x)))
;; if our guess is good enough, return it,
;;else call (curt-iter) with an improved guess


(define (cb-root x)
  (curt-iter 1.0 x)) ;; Call curt-iter with the guess of 1
