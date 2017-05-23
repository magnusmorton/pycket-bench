#lang racket/base
(require "time-run.rktl")

(define (fib n)
  (cond ((< n 2) 1)
        (else (+ (fib (- n 2)) (fib (- n 1))))))

(time-run fib)#lang racket/base
(require "time-run.rktl")

(define (fib n)
  (cond ((< n 2) 1)
        (else (+ (fib (- n 2)) (fib (- n 1))))))

(time-run fib)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
