;; $Id: regexmatch-mzscheme.code,v 1.9 2006/06/21 15:05:29 bfulgham Exp $
;;; http://shootout.alioth.debian.org/
;;;
;;; Based on the Chicken implementation
;;; Contributed by Brent Fulgham

;; Uses byte regexps instead of string regexps for a fairer comparison

;; NOTE: the running time of this benchmark is dominated by
;; construction of the `num' string.

#lang racket/base
(require "time-run.rktl")

(require racket/match racket/port)

(define rx
  (string-append
   "(?:^|[^0-9\\(])"                    ; (1) preceding non-digit or bol
   "("                                  ; (2) area code
   "\\(([0-9][0-9][0-9])\\)"            ; (3) is either 3 digits in parens
   "|"                                  ; or
   "([0-9][0-9][0-9])"                  ; (4) just 3 digits
   ")"                                  ; end of area code
   " "                                  ; area code is followed by one space
   "([0-9][0-9][0-9])"                  ; (5) exchange is 3 digits
   "[ -]"                               ; separator is either space or dash
   "([0-9][0-9][0-9][0-9])"             ; (6) last 4 digits
   "(?:[^0-9]|$)"                       ; must be followed by a non-digit
   ))

(define (benchargs args)
 (let* ([file-name (if (= (vector-length args) 0)
                       (error "No file to process")
                       (vector-ref args 0))]
        [file      (open-input-file file-name)]
        [out       (open-output-string)]
        [n         (if (< (vector-length args) 2) "1" (vector-ref args 1))])
   (copy-port file out)
   (cons n (open-input-string (get-output-string out)))))


(define (bench n-in)
  (let ((n (car n-in))
        (in (cdr n-in))
        (phonelines '())
        (rx (byte-regexp (string->bytes/utf-8 rx)))
        (count 0))
    (let loop ((line (read-bytes-line in)))
      (cond ((eof-object? line) #f)
            (else
             (set! phonelines (cons line phonelines))
             (loop (read-bytes-line in)))))
    (set! phonelines (reverse phonelines))
    (do ([n (string->number n) (sub1 n)])
        ((negative? n))
      (let loop ((phones phonelines)
                 (count 0))
        (if (null? phones)
            count
            (let ([m (regexp-match rx (car phones))])
              (if m
                  (match-let ([(list a1 a2 a3 exch numb) (cdr m)])
                    (let* ([area (and a1 (or a2 a3))]
                           [num (bytes-append #"(" area #") " exch #"-" numb)]
                           [count (add1 count)])
                      (when (zero? n)
                        (printf "~a: ~a\n" count num))
                      (loop (cdr phones) count)))
                  (loop (cdr phones) count))))))))

(time-run bench benchargs);; $Id: regexmatch-mzscheme.code,v 1.9 2006/06/21 15:05:29 bfulgham Exp $
;;; http://shootout.alioth.debian.org/
;;;
;;; Based on the Chicken implementation
;;; Contributed by Brent Fulgham

;; Uses byte regexps instead of string regexps for a fairer comparison

;; NOTE: the running time of this benchmark is dominated by
;; construction of the `num' string.

#lang racket/base
(require "time-run.rktl")

(require racket/match racket/port)

(define rx
  (string-append
   "(?:^|[^0-9\(])"                    ; (1) preceding non-digit or bol
   "("                                  ; (2) area code
   "\(([0-9][0-9][0-9])\)"            ; (3) is either 3 digits in parens
   "|"                                  ; or
   "([0-9][0-9][0-9])"                  ; (4) just 3 digits
   ")"                                  ; end of area code
   " "                                  ; area code is followed by one space
   "([0-9][0-9][0-9])"                  ; (5) exchange is 3 digits
   "[ -]"                               ; separator is either space or dash
   "([0-9][0-9][0-9][0-9])"             ; (6) last 4 digits
   "(?:[^0-9]|$)"                       ; must be followed by a non-digit
   ))

(define (benchargs args)
 (let* ([file-name (if (= (vector-length args) 0)
                       (error "No file to process")
                       (vector-ref args 0))]
        [file      (open-input-file file-name)]
        [out       (open-output-string)]
        [n         (if (< (vector-length args) 2) "1" (vector-ref args 1))])
   (copy-port file out)
   (cons n (open-input-string (get-output-string out)))))


(define (bench n-in)
  (let ((n (car n-in))
        (in (cdr n-in))
        (phonelines '())
        (rx (byte-regexp (string->bytes/utf-8 rx)))
        (count 0))
    (let loop ((line (read-bytes-line in)))
      (cond ((eof-object? line) #f)
            (else
             (set! phonelines (cons line phonelines))
             (loop (read-bytes-line in)))))
    (set! phonelines (reverse phonelines))
    (do ([n (string->number n) (sub1 n)])
        ((negative? n))
      (let loop ((phones phonelines)
                 (count 0))
        (if (null? phones)
            count
            (let ([m (regexp-match rx (car phones))])
              (if m
                  (match-let ([(list a1 a2 a3 exch numb) (cdr m)])
                    (let* ([area (and a1 (or a2 a3))]
                           [num (bytes-append #"(" area #") " exch #"-" numb)]
                           [count (add1 count)])
                      (when (zero? n)
                        (printf "~a: ~a
" count num))
                      (loop (cdr phones) count)))
                  (loop (cdr phones) count))))))))

(time-run bench benchargs)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
