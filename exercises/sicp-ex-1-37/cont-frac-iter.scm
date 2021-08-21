(define (cont-frac n d k)
  (cont-frac-iter n d (- k 1)(/ (n k) (d k))))

(define (cont-frac-iter n d i cur-val)
  (let ((n-value (n i))
        (d-value (d i)))
    (if (= i 0)
        cur-val
        (cont-frac-iter n d (- i 1)(/ n-value (+ d-value cur-val))))))
