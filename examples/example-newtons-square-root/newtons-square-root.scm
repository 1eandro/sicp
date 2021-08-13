(define (average x y)
  (/ (+ x y) 2)) ;; divide the sum of x and y by 2


(define (improve-guess guess x)
  (average guess (/ x guess)));; return the average of guess and guess divided by x

(define (square x)
  (* x x));; returns the square of a numeral

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001));; compare the guess's square and x


(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve-guess guess x)
                 x)))
  ;; if our guess is good enough, return it,
  ;;else call (sqrt-iter) with an improved guess


(define (square-root x)
  (sqrt-iter 1.0 x)) ;; Call sqrt-iter with the guess of 1


