;
;  Faster, more idiomatic Scheme by Neil Van Dyke
;

#lang racket/base
(require "time-run.rktl")
(require racket/port)

(define (benchargs args)
  (let* ([file-name (if (= (vector-length args) 0)
                        (error "No file to process")
                        (vector-ref args 0))]
         [file      (open-input-file file-name)]
         [out       (open-output-string)])
    (copy-port file out)
    (open-input-string (get-output-string out))))

(define (bench iport)
  (apply printf "~s ~s ~s\n"
         (let wc ((i #f) (lines 0) (words 0) (chars 0))
           (let ((x (read-char iport)))
             (if (eof-object? x)
                 (list lines words chars)
                 (case x
                   ((#\newline)     (wc #f (add1 lines) words (add1 chars)))
                   ((#\space #\tab) (wc #f       lines  words (add1 chars)))
                   (else
                    (wc #t lines (if i words (add1 words)) (add1 chars)))))))))

(time-run bench benchargs);
;  Faster, more idiomatic Scheme by Neil Van Dyke
;

#lang racket/base
(require "time-run.rktl")
(require racket/port)

(define (benchargs args)
  (let* ([file-name (if (= (vector-length args) 0)
                        (error "No file to process")
                        (vector-ref args 0))]
         [file      (open-input-file file-name)]
         [out       (open-output-string)])
    (copy-port file out)
    (open-input-string (get-output-string out))))

(define (bench iport)
  (apply printf "~s ~s ~s
"
         (let wc ((i #f) (lines 0) (words 0) (chars 0))
           (let ((x (read-char iport)))
             (if (eof-object? x)
                 (list lines words chars)
                 (case x
                   ((#
ewline)     (wc #f (add1 lines) words (add1 chars)))
                   ((#\space #	ab) (wc #f       lines  words (add1 chars)))
                   (else
                    (wc #t lines (if i words (add1 words)) (add1 chars)))))))))

(time-run bench benchargs)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
