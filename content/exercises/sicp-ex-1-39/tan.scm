(define (tan x k)
  (cont-frac (lambda (i)(if (= i 1)x(* x x))) (lambda (i)(- (* i 2) 1)) k))

(define (cont-frac n d k)
  (cont-frac-reccur n d k 1))

(define (cont-frac-reccur n d k i)
  (let ((n-value (n i))
         (d-value (d i)))
     (if (= i k)
          (/ n-value d-value)
          (/ n-value (+ d-value
                     (cont-frac-reccur n d k (+ i 1)))))))
