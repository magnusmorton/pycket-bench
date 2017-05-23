#lang racket/base
(require "time-run.rktl")

(define (generate receive-ch n)
  (if (zero? n)
      receive-ch
      (let ([ch (make-channel)])
        (thread (lambda ()
                  (let loop ()
                    (channel-put ch (add1 (channel-get receive-ch)))
                    (loop))))
        (generate ch (sub1 n)))))



(define (bench n)
  (let* ([start-ch (make-channel)]
         [end-ch (generate start-ch 500)])
    (let loop ([n n][total 0])
      (if (zero? n)
          (printf "~a\n" total)
          (begin
            (channel-put start-ch 0)
            (loop (sub1 n)
                  (+ total (channel-get end-ch))))))))

(time-run bench)#lang racket/base
(require "time-run.rktl")

(define (generate receive-ch n)
  (if (zero? n)
      receive-ch
      (let ([ch (make-channel)])
        (thread (lambda ()
                  (let loop ()
                    (channel-put ch (add1 (channel-get receive-ch)))
                    (loop))))
        (generate ch (sub1 n)))))



(define (bench n)
  (let* ([start-ch (make-channel)]
         [end-ch (generate start-ch 500)])
    (let loop ([n n][total 0])
      (if (zero? n)
          (printf "~a
" total)
          (begin
            (channel-put start-ch 0)
            (loop (sub1 n)
                  (+ total (channel-get end-ch))))))))

(time-run bench)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
