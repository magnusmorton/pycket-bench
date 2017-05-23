#lang racket/base

;; The Computer Language Benchmarks Game
;; http://shootout.alioth.debian.org/
;;
;; Based on a version by by Anthony Borla

(require "time-run.rktl")

(require racket/port)

;; -------------------------------

(define VARIANTS
  '(#"agggtaaa|tttaccct" #"[cgt]gggtaaa|tttaccc[acg]" #"a[act]ggtaaa|tttacc[agt]t"
    #"ag[act]gtaaa|tttac[agt]ct" #"agg[act]taaa|ttta[agt]cct" #"aggg[acg]aaa|ttt[cgt]ccct"
    #"agggt[cgt]aa|tt[acg]accct" #"agggta[cgt]a|t[acg]taccct" #"agggtaa[cgt]|[acg]ttaccct"))


(define IUBS
  '((#"B" #"(c|g|t)") (#"D" #"(a|g|t)") (#"H" #"(a|c|t)")
    (#"K" #"(g|t)") (#"M" #"(a|c)") (#"N" #"(a|c|g|t)")
    (#"R" #"(a|g)") (#"S" #"(c|g)") (#"V" #"(a|c|g)")
    (#"W" #"(a|t)") (#"Y" #"(c|t)")))

;; -------------------------------

(define (ci-byte-regexp s)
  (byte-regexp (bytes-append #"(?i:" s #")")))

;; -------------------------------

(define (match-count str rx offset cnt)
  (let ([m (regexp-match-positions rx str offset)])
    (if m
        (match-count str rx (cdar m) (add1 cnt))
        cnt)))

;; -------------------------------

(define (benchargs args)
  (let* ([file-name (if (= (vector-length args) 0)
                        (error "No file to process")
                        (vector-ref args 0))]
         [file      (open-input-file file-name)])
    (string->bytes/locale (port->string file))))

(define (bench orig)
  ;; Load sequence and record its length
  (let ([filtered (regexp-replace* #rx#"(?:>.*?\n)|\n" orig #"")])

    ;; Perform regexp counts
    (for ([i (in-list VARIANTS)])
      (printf "~a ~a\n" i (match-count filtered (ci-byte-regexp i) 0 0)))

    ;; Perform regexp replacements, and record sequence length
    (let ([replaced
           (for/fold ([sequence filtered]) ([IUB IUBS])
             (regexp-replace* (byte-regexp (car IUB)) sequence (cadr IUB)))])
      ;; Print statistics
      (printf "\n~a\n~a\n~a\n" 
              (bytes-length orig)
              (bytes-length filtered)
              (bytes-length replaced)))))

(time-run bench benchargs)#lang racket/base

;; The Computer Language Benchmarks Game
;; http://shootout.alioth.debian.org/
;;
;; Based on a version by by Anthony Borla

(require "time-run.rktl")

(require racket/port)

;; -------------------------------

(define VARIANTS
  '(#"agggtaaa|tttaccct" #"[cgt]gggtaaa|tttaccc[acg]" #"a[act]ggtaaa|tttacc[agt]t"
    #"ag[act]gtaaa|tttac[agt]ct" #"agg[act]taaa|ttta[agt]cct" #"aggg[acg]aaa|ttt[cgt]ccct"
    #"agggt[cgt]aa|tt[acg]accct" #"agggta[cgt]a|t[acg]taccct" #"agggtaa[cgt]|[acg]ttaccct"))


(define IUBS
  '((#"B" #"(c|g|t)") (#"D" #"(a|g|t)") (#"H" #"(a|c|t)")
    (#"K" #"(g|t)") (#"M" #"(a|c)") (#"N" #"(a|c|g|t)")
    (#"R" #"(a|g)") (#"S" #"(c|g)") (#"V" #"(a|c|g)")
    (#"W" #"(a|t)") (#"Y" #"(c|t)")))

;; -------------------------------

(define (ci-byte-regexp s)
  (byte-regexp (bytes-append #"(?i:" s #")")))

;; -------------------------------

(define (match-count str rx offset cnt)
  (let ([m (regexp-match-positions rx str offset)])
    (if m
        (match-count str rx (cdar m) (add1 cnt))
        cnt)))

;; -------------------------------

(define (benchargs args)
  (let* ([file-name (if (= (vector-length args) 0)
                        (error "No file to process")
                        (vector-ref args 0))]
         [file      (open-input-file file-name)])
    (string->bytes/locale (port->string file))))

(define (bench orig)
  ;; Load sequence and record its length
  (let ([filtered (regexp-replace* #rx#"(?:>.*?
)|
" orig #"")])

    ;; Perform regexp counts
    (for ([i (in-list VARIANTS)])
      (printf "~a ~a
" i (match-count filtered (ci-byte-regexp i) 0 0)))

    ;; Perform regexp replacements, and record sequence length
    (let ([replaced
           (for/fold ([sequence filtered]) ([IUB IUBS])
             (regexp-replace* (byte-regexp (car IUB)) sequence (cadr IUB)))])
      ;; Print statistics
      (printf "
~a
~a
~a
" 
              (bytes-length orig)
              (bytes-length filtered)
              (bytes-length replaced)))))

(time-run bench benchargs)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
