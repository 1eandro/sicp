(define (p col row)
  (if (or (= col 0) (= col row))
      1
      (+ (p (- col 1) (- row 1)) (p col (- row 1)))))

(define (row n)
  (row-iter '() n  n))


(define (row-iter row row-n n)
  (if (= n 0)
      row
      (row-iter (extend row (p n row-n)) row-n (- n 1))))


(define (extend l . xs)
  (if (null? l)
      xs
      (cons (car l) (apply extend (cdr l) xs))))

(define (tetra n)
  (co-iter `() 2 0 n))

(define (co-iter list row n count)
  (if (= count 0)
      list
      (co-iter (extend list (p n row)) (+ row 1) (+ n 1) (- count 1) )))


(define (tri n)
  (tri-iter `() 1 (+ n 1)))


(define (tri-iter list n count)
  (if (= count n)
      list
      (tri-iter (extend list (row n)) (+ n 1) count)))
