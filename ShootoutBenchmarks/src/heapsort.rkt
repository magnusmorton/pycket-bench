;;; heapsort.scm

;; Prints 0.9990640717878372 instead of 0.9990640718 when n=1000.
;; Updated by Justin Smith
;;
;; Updated by Brent Fulgham to provide proper output formatting

#lang racket/base
(require "time-run.rktl")

(define IM   139968)
(define IA     3877)
(define IC    29573)

(define LAST 42)
(define (gen_random max)
  (set! LAST (modulo (+ (* LAST IA) IC) IM))
  (/ (* max LAST) IM))

(define (heapsort n ra)
  (let ((ir n)
        (l (+ (quotient n 2) 1))
        (i 0)
        (j 0)
        (rra 0.0))
    (let/ec return
      (do ((bar #t))
          ((= 1 0))
        (cond ((> l 1)
               (set! l (- l 1))
               (set! rra (vector-ref ra l)))
              (else
               (set! rra (vector-ref ra ir))
               (vector-set! ra ir (vector-ref ra 1))
               (set! ir (- ir 1))
               (cond ((<= ir 1)
                      (vector-set! ra 1 rra)
                      (return #t)))))
        (set! i l)
        (set! j (* l 2))
        (do ((foo #t))
            ((> j ir))
          (cond ((and (< j ir) (< (vector-ref ra j) (vector-ref ra (+ j 1))))
                 (set! j (+ j 1))))
          (cond ((< rra (vector-ref ra j))
                 (vector-set! ra i (vector-ref ra j))
                 (set! i j)
                 (set! j (+ j i)))
                (else
                 (set! j (+ ir 1)))))
        (vector-set! ra i rra)))))



(define (bench n)
  (let* ((last (+ n 1))
         (ary (make-vector last 0)))
    (do ((i 1 (+ i 1)))
        ((= i last))
      (vector-set! ary i (gen_random 1.0)))
    (heapsort n ary)
    (printf "~a\n"
            (real->decimal-string (vector-ref ary n) 10))))

(time-run bench);;; heapsort.scm

;; Prints 0.9990640717878372 instead of 0.9990640718 when n=1000.
;; Updated by Justin Smith
;;
;; Updated by Brent Fulgham to provide proper output formatting

#lang racket/base
(require "time-run.rktl")

(define IM   139968)
(define IA     3877)
(define IC    29573)

(define LAST 42)
(define (gen_random max)
  (set! LAST (modulo (+ (* LAST IA) IC) IM))
  (/ (* max LAST) IM))

(define (heapsort n ra)
  (let ((ir n)
        (l (+ (quotient n 2) 1))
        (i 0)
        (j 0)
        (rra 0.0))
    (let/ec return
      (do ((bar #t))
          ((= 1 0))
        (cond ((> l 1)
               (set! l (- l 1))
               (set! rra (vector-ref ra l)))
              (else
               (set! rra (vector-ref ra ir))
               (vector-set! ra ir (vector-ref ra 1))
               (set! ir (- ir 1))
               (cond ((<= ir 1)
                      (vector-set! ra 1 rra)
                      (return #t)))))
        (set! i l)
        (set! j (* l 2))
        (do ((foo #t))
            ((> j ir))
          (cond ((and (< j ir) (< (vector-ref ra j) (vector-ref ra (+ j 1))))
                 (set! j (+ j 1))))
          (cond ((< rra (vector-ref ra j))
                 (vector-set! ra i (vector-ref ra j))
                 (set! i j)
                 (set! j (+ j i)))
                (else
                 (set! j (+ ir 1)))))
        (vector-set! ra i rra)))))



(define (bench n)
  (let* ((last (+ n 1))
         (ary (make-vector last 0)))
    (do ((i 1 (+ i 1)))
        ((= i last))
      (vector-set! ary i (gen_random 1.0)))
    (heapsort n ary)
    (printf "~a
"
            (real->decimal-string (vector-ref ary n) 10))))

(time-run bench)
(require "cost.rkt")
(define eqns (equations))
(printf "~a,~a,~a,~a,~a,~a~n" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))
