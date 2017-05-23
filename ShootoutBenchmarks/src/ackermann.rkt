#lang racket/base
(require "time-run.rktl")

(define (ack m n)
  (cond ((zero? m) (+ n 1))
        ((zero? n) (ack (- m 1) 1))
        (else      (ack (- m 1) (ack m (- n 1))))))

(define (bench arg)
  (ack 3 arg))

(time-run bench)
#lang racket/base
(require "time-run.rktl")

(define (ack m n)
  (cond ((zero? m) (+ n 1))
        ((zero? n) (ack (- m 1) 1))
        (else      (ack (- m 1) (ack m (- n 1))))))

(define (bench arg)
  (ack 3 arg))

(time-run bench)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
