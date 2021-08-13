(define (expt n power)
  (expt-iter n 1 power))

(define (expt-iter n mul count)
  (if (= count 0)
      mul
      (expt-iter n (* mul n) (- count 1))))
