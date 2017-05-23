#lang racket/base
(require "time-run.rktl")

;; The Computer Language Benchmarks Game
;; http://shootout.alioth.debian.org/
;;
;; Uses Racket threads

;; Each thread runs this loop:
(define (run id next)
  (let ([v (thread-receive)])
    (cond
     [(zero? v) ;; Done
      (printf "~a\n" id)
      (exit)]
     [else ;; Keep going
      (thread-send next (sub1 v))
      (run id next)])))



(define (bench n)
  ;; The original thread is #503. Create the rest:
  (let ([t1 (for/fold ([next (current-thread)])
                      ([id (in-range 502 0 -1)])
              (thread (lambda () (run id next))))])
    ;; Start:
    (thread-send t1 n)
    (run 503 t1)))

(time-run bench)#lang racket/base
(require "time-run.rktl")

;; The Computer Language Benchmarks Game
;; http://shootout.alioth.debian.org/
;;
;; Uses Racket threads

;; Each thread runs this loop:
(define (run id next)
  (let ([v (thread-receive)])
    (cond
     [(zero? v) ;; Done
      (printf "~a
" id)
      (exit)]
     [else ;; Keep going
      (thread-send next (sub1 v))
      (run id next)])))



(define (bench n)
  ;; The original thread is #503. Create the rest:
  (let ([t1 (for/fold ([next (current-thread)])
                      ([id (in-range 502 0 -1)])
              (thread (lambda () (run id next))))])
    ;; Start:
    (thread-send t1 n)
    (run 503 t1)))

(time-run bench)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
