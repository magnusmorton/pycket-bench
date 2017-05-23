#lang racket/base
(require "time-run.rktl")


(define (bench n)
  (let* ([hash (make-hash)]
         [accum 0]
         [false (lambda () #f)])
    (let loop ([i 1])
      (unless (> i n)
        (hash-set! hash (number->string i 16) i)
        (loop (add1 i))))
    (let loop ([i n])
      (unless (zero? i)
        (when (hash-ref hash (number->string i) false)
          (set! accum (+ accum 1)))
        (loop (sub1 i))))
    (printf "~s\n" accum)))

(time-run bench)#lang racket/base
(require "time-run.rktl")


(define (bench n)
  (let* ([hash (make-hash)]
         [accum 0]
         [false (lambda () #f)])
    (let loop ([i 1])
      (unless (> i n)
        (hash-set! hash (number->string i 16) i)
        (loop (add1 i))))
    (let loop ([i n])
      (unless (zero? i)
        (when (hash-ref hash (number->string i) false)
          (set! accum (+ accum 1)))
        (loop (sub1 i))))
    (printf "~s
" accum)))

(time-run bench)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
