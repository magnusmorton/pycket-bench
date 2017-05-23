#lang racket/base
(require "time-run.rktl")
(define (bench n) 1)
(time-run bench)
#lang racket/base
(require "time-run.rktl")
(define (bench n) 1)
(time-run bench)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
