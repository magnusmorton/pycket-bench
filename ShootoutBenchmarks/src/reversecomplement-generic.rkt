#lang racket/base

;; The Computer Language Benchmarks Game
;; http://shootout.alioth.debian.org/
(require "time-run.rktl" racket/port)
(require (for-syntax racket/base))

(define translation (make-vector 128))

(for ([from (in-string "ACGTUMRWSYKVHDBN")]
      [to   (in-string "TGCAAKYWSRMBDHVN")])
  (let ([to (char->integer to)])
    (vector-set! translation (char->integer from) to)
    (vector-set! translation (char->integer (char-downcase from)) to)))

;(define I (current-input-port))
(define O (current-output-port))



(define marker (char->integer #\>))

(define line-length 60)
(define buf-size (* 64 1024))
(define out-buf ; so there's always enough room for newlines
  (make-bytes (+ buf-size 1 (quotient buf-size line-length))))
(define LF (char->integer #\newline))

#|
The basic idea is to read the input in chunks, and keep pointers to
them, then on output process each chunk to translate and reverse it
before dumping it out.
|#

(define (output chunks)
  (let loop ([chunks chunks] [col line-length])
    (when (pair? chunks)
      (let ([chunk (car chunks)])
        (let ([start  (vector-ref chunk 0)]
              [end    (vector-ref chunk 1)]
              [in-buf (vector-ref chunk 2)])
          (let chunk-loop ([i end] [j 0] [col col])
            (if (> i start)
              (let* ([i (- i 1)] [b (bytes-ref in-buf i)])
                (if (= b LF)
                  (chunk-loop i j col)
                  (let ([b (vector-ref translation b)])
                    (if (= 0 col)
                      (begin (bytes-set! out-buf j LF)
                             (bytes-set! out-buf (+ j 1) b)
                             (chunk-loop i (+ j 2) (- line-length 1)))
                      (begin (bytes-set! out-buf j b)
                             (chunk-loop i (+ j 1) (- col 1)))))))
              (begin (write-bytes out-buf O 0 j)
                     (loop (cdr chunks) col))))))))
  (newline O))

(define-syntax case-regexp-posns
  (syntax-rules (=> else)
    [(_ rx buf start [id B1 ...] [else B2 ...])
     (let ([m (regexp-match-positions rx buf start)])
       (if m (let ([id (car m)]) B1 ...) (begin B2 ...)))]))

(define (benchargs args)
  (let* ([file-name (if (= (vector-length args) 0)
                        (error "No file to process")
                        (vector-ref args 0))]
         [file      (open-input-file file-name)]
         [out       (open-output-string)])
    (copy-port file out)
    (open-input-string (get-output-string out))))

(define (bench I)

  (let ([m (regexp-match #rx"^([^\n]+)\n" I)]) (display (car m)))

  (let loop ([buf (read-bytes buf-size I)] [start 0] [chunks '()])
    (if (eof-object? buf)
      (begin (output chunks) (void))
      (case-regexp-posns #rx">" buf start
        [p1 (output (cons (vector start (car p1) buf) chunks))
            (case-regexp-posns #rx"\n" buf (cdr p1)
              [p2 (write-bytes buf O (car p1) (cdr p2))
                  (loop buf (cdr p2) '())]
              [else (write-bytes buf O (car p1))
                    (let header-loop ()
                      (let ([buf (read-bytes buf-size I)])
                        (case-regexp-posns #rx"\n" buf 0
                          [p2 (write-bytes buf O 0 (cdr p2))
                              (loop buf (cdr p2) '())]
                          [else (write-bytes buf O) (header-loop)])))])]
        [else (loop (read-bytes buf-size I) 0
                    (cons (vector start (bytes-length buf) buf) chunks))]))))

(time-run bench benchargs)
#lang racket/base

;; The Computer Language Benchmarks Game
;; http://shootout.alioth.debian.org/
(require "time-run.rktl" racket/port)
(require (for-syntax racket/base))

(define translation (make-vector 128))

(for ([from (in-string "ACGTUMRWSYKVHDBN")]
      [to   (in-string "TGCAAKYWSRMBDHVN")])
  (let ([to (char->integer to)])
    (vector-set! translation (char->integer from) to)
    (vector-set! translation (char->integer (char-downcase from)) to)))

;(define I (current-input-port))
(define O (current-output-port))



(define marker (char->integer #\>))

(define line-length 60)
(define buf-size (* 64 1024))
(define out-buf ; so there's always enough room for newlines
  (make-bytes (+ buf-size 1 (quotient buf-size line-length))))
(define LF (char->integer #
ewline))

#|
The basic idea is to read the input in chunks, and keep pointers to
them, then on output process each chunk to translate and reverse it
before dumping it out.
|#

(define (output chunks)
  (let loop ([chunks chunks] [col line-length])
    (when (pair? chunks)
      (let ([chunk (car chunks)])
        (let ([start  (vector-ref chunk 0)]
              [end    (vector-ref chunk 1)]
              [in-buf (vector-ref chunk 2)])
          (let chunk-loop ([i end] [j 0] [col col])
            (if (> i start)
              (let* ([i (- i 1)] [b (bytes-ref in-buf i)])
                (if (= b LF)
                  (chunk-loop i j col)
                  (let ([b (vector-ref translation b)])
                    (if (= 0 col)
                      (begin (bytes-set! out-buf j LF)
                             (bytes-set! out-buf (+ j 1) b)
                             (chunk-loop i (+ j 2) (- line-length 1)))
                      (begin (bytes-set! out-buf j b)
                             (chunk-loop i (+ j 1) (- col 1)))))))
              (begin (write-bytes out-buf O 0 j)
                     (loop (cdr chunks) col))))))))
  (newline O))

(define-syntax case-regexp-posns
  (syntax-rules (=> else)
    [(_ rx buf start [id B1 ...] [else B2 ...])
     (let ([m (regexp-match-positions rx buf start)])
       (if m (let ([id (car m)]) B1 ...) (begin B2 ...)))]))

(define (benchargs args)
  (let* ([file-name (if (= (vector-length args) 0)
                        (error "No file to process")
                        (vector-ref args 0))]
         [file      (open-input-file file-name)]
         [out       (open-output-string)])
    (copy-port file out)
    (open-input-string (get-output-string out))))

(define (bench I)

  (let ([m (regexp-match #rx"^([^
]+)
" I)]) (display (car m)))

  (let loop ([buf (read-bytes buf-size I)] [start 0] [chunks '()])
    (if (eof-object? buf)
      (begin (output chunks) (void))
      (case-regexp-posns #rx">" buf start
        [p1 (output (cons (vector start (car p1) buf) chunks))
            (case-regexp-posns #rx"
" buf (cdr p1)
              [p2 (write-bytes buf O (car p1) (cdr p2))
                  (loop buf (cdr p2) '())]
              [else (write-bytes buf O (car p1))
                    (let header-loop ()
                      (let ([buf (read-bytes buf-size I)])
                        (case-regexp-posns #rx"
" buf 0
                          [p2 (write-bytes buf O 0 (cdr p2))
                              (loop buf (cdr p2) '())]
                          [else (write-bytes buf O) (header-loop)])))])]
        [else (loop (read-bytes buf-size I) 0
                    (cons (vector start (bytes-length buf) buf) chunks))]))))

(time-run bench benchargs)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
