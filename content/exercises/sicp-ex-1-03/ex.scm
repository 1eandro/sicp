;;Sicp ex 1.3

(define (sqr x)
  ;;x is the numeral to be squared
  (* x x))


(define (sum-squares x y)
  ;;x is numeral 1 and y numeral 2
  (+ (sqr x) (sqr y)))


(define (func x y z)
  ;;x is numeral 1, y is numeral 2 and z numeral 3
  (cond ((and (>= x y) (>= y z)) (sum-squares x y))
        ((and (>= x y) (>= z y)) (sum-squares x z))
        ((and (>= y x) (>= z x)) (sum-squares z y))))
