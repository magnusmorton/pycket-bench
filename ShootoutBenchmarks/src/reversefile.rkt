;;; -*- mode: scheme -*-
;;; $Id: reversefile-mzscheme.code,v 1.10 2006/06/21 15:05:29 bfulgham Exp $
;;; http://shootout.alioth.debian.org/
;;; Provided by Bengt Kleberg

#lang racket/base
(require "time-run.rktl")

(require racket/port)

(define (benchargs args)
  (let* ([file-name (if (= (vector-length args) 0)
                        (error "No file to process")
                        (vector-ref args 0))]
         [file      (open-input-file file-name)])
    (string->bytes/locale (port->string file))))


(define (bench bytes)
  (let ([inport (open-input-bytes bytes)])
    (let rev ([lines null])
      (let ([line (read-bytes-line inport)])
        (if (eof-object? line)
            (for-each (lambda (l) (printf "~a\n" l))
                      lines)
            (rev (cons line lines)))))))

(time-run bench benchargs);;; -*- mode: scheme -*-
;;; $Id: reversefile-mzscheme.code,v 1.10 2006/06/21 15:05:29 bfulgham Exp $
;;; http://shootout.alioth.debian.org/
;;; Provided by Bengt Kleberg

#lang racket/base
(require "time-run.rktl")

(require racket/port)

(define (benchargs args)
  (let* ([file-name (if (= (vector-length args) 0)
                        (error "No file to process")
                        (vector-ref args 0))]
         [file      (open-input-file file-name)])
    (string->bytes/locale (port->string file))))


(define (bench bytes)
  (let ([inport (open-input-bytes bytes)])
    (let rev ([lines null])
      (let ([line (read-bytes-line inport)])
        (if (eof-object? line)
            (for-each (lambda (l) (printf "~a
" l))
                      lines)
            (rev (cons line lines)))))))

(time-run bench benchargs)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
