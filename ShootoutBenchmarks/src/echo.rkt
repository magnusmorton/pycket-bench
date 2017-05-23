#lang racket/base
(require "time-run.rktl")
(require racket/tcp)

(define PORT 8887)
(define DATA "Hello there sailor\n")
(define n 10)

(define (server)
  (thread client)
  (let-values ([(in out) (tcp-accept (tcp-listen PORT 5 #t))]
               [(buffer) (make-string (string-length DATA))])
    (file-stream-buffer-mode out 'none)
    (let loop ([i (read-string! buffer in)]
               [bytes 0])
      (if (not (eof-object? i))
          (begin
            (display buffer out)
            (loop (read-string! buffer in)
                  (+ bytes (string-length buffer))))
          (begin
            (display "server processed ")
            (display bytes)
            (display " bytes\n"))))))

(define (client)
  (let-values ([(in out) (tcp-connect "127.0.0.1" PORT)]
               [(buffer) (make-string (string-length DATA))])
    (file-stream-buffer-mode out 'none)
    (let loop ([n n])
      (if (> n 0)
          (begin
            (display DATA out)
            (let ([i (read-string! buffer in)])
              (begin
                (if (equal? DATA buffer)
                    (loop (- n 1))
                    'error))))
          (close-output-port out)))))

(define (benchargs args)
  (set! n
        (if (= (vector-length args) 0)
            1
            (string->number (vector-ref  args 0))))
  (void))
(define (bench *ignore*)
  (server))
  
(time-run bench benchargs)
#lang racket/base
(require "time-run.rktl")
(require racket/tcp)

(define PORT 8887)
(define DATA "Hello there sailor
")
(define n 10)

(define (server)
  (thread client)
  (let-values ([(in out) (tcp-accept (tcp-listen PORT 5 #t))]
               [(buffer) (make-string (string-length DATA))])
    (file-stream-buffer-mode out 'none)
    (let loop ([i (read-string! buffer in)]
               [bytes 0])
      (if (not (eof-object? i))
          (begin
            (display buffer out)
            (loop (read-string! buffer in)
                  (+ bytes (string-length buffer))))
          (begin
            (display "server processed ")
            (display bytes)
            (display " bytes
"))))))

(define (client)
  (let-values ([(in out) (tcp-connect "127.0.0.1" PORT)]
               [(buffer) (make-string (string-length DATA))])
    (file-stream-buffer-mode out 'none)
    (let loop ([n n])
      (if (> n 0)
          (begin
            (display DATA out)
            (let ([i (read-string! buffer in)])
              (begin
                (if (equal? DATA buffer)
                    (loop (- n 1))
                    'error))))
          (close-output-port out)))))

(define (benchargs args)
  (set! n
        (if (= (vector-length args) 0)
            1
            (string->number (vector-ref  args 0))))
  (void))
(define (bench *ignore*)
  (server))
  
(time-run bench benchargs)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
