(define (d i)
  (let ((by-3 (/ (+ i 1) 3)))
    (if (integer? by-3)
        (* 2 by-3)
        1)))

(define (cont-frac n d k)
  (cont-frac-reccur n d k 1))

(define (cont-frac-reccur n d k i)
  (let ((n-value (n i))
         (d-value (d i)))
     (if (= i k)
          (/ n-value d-value)
          (/ n-value (+ d-value
                     (cont-frac-reccur n d k (+ i 1)))))))
(define (e)
  (+ 2 (cont-frac (lambda (i) 1.0) d 20)))
