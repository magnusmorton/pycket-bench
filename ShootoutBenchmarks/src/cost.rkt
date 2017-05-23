#lang pycket


(require pycket/extra-prims/trace-info)
(require racket/flonum)
(require racket/string)
(require racket/list)
(require racket/function)
(require racket/hash)
(provide
 task-cost
 model
 histogram
 missing-traces
 snapshot-counts
 equations)

(define frag-memo (make-hash))

(define (is-alloc? symbol)
  (eqv? (string-ref symbol 0) #\n))

(define (is-guard? symbol)
  (eqv? (string-ref symbol 0) #\g))

(define (is-num? symbol)
  (or (eqv? (string-ref symbol 0) #\i)
    (eqv? (string-ref symbol 0) #\f)))

(define (is-debug? symbol)
  (eqv? (string-ref symbol 0) #\d))

(define (weight-lookup symbol)
  (case symbol
    [(#\n) 4.797e-03]
    [(#\g) 4.623e-04]
    [(#\i) 4.884e-04]
    [(#\f) 4.884e-04]
    [else 0.0]))

(define (counting symbol)
  (if (not (is-debug? symbol))
      1
      0))

(define model weight-lookup)

(define current-counts #hash())

(define (class-counts counts traces )
  (void))

(define (snapshot-counts)
  (set! current-counts (counters)))


(define (diff-counts new-counts old-counts)
  (for/hash ([(key value) (in-hash new-counts)])
    (values key (- value (hash-ref old-counts key 0)))))

(define (task-cost)
  (let* ([counts (counters)]
         [diffs (diff-counts counts current-counts)]
         [traces (get-trace-db)])
    (cost diffs traces)))

(define (equations)
  (let* ([counts (counters)]
         [diffs (diff-counts counts current-counts)]
         [traces (get-trace-db)])
    (printf "diffs: ~a~n" diffs)
    (printf "traces ~a~n" traces)
    (eqns diffs traces)))

(define (histogram)
  (let* ([counts (counters)]
         [diffs (diff-counts counts current-counts)]
         [traces (get-trace-db)])
    (instruction-frequency diffs traces)))


(define (frag-cost  frag k)
  (if (hash-has-key? frag-memo k)
    (hash-ref frag-memo k)
    (for/fold ([tot 0.0])
              ([ins frag])
              (+ tot (model ins)))))

(define (list-frag frag)
  (for ([ins frag])
       (printf "ins ~a~n" ins)))


(define (frag-cost-to  frag max-iter)
  (for/fold ([tot 0.0])
            ([ins frag]
             [i max-iter])
    (+ tot (model ins))))

(define (flatten-frag frag )
  (printf "frag: ~a~n" frag)
  (let ([flat (make-hash)])
    (for ([ins frag])
         (printf "ins: ~a~n" ins)
         (display (class? ins))
         (hash-update! flat (class? ins) (lambda (x) (+ x 1)) 0))
    (printf "fl: ~a~n" flat)
    flat))


(define (guard-counts-indices counts guards)
  (for/list ([guard guards]
        #:when (hash-has-key? counts (car guard)))
    (cons (hash-ref counts (car guard)) (cdr guard))))

;; if this seems odd, it's because it's doing two things at once because performance
(define (calc-neg-extra frag gps cost)
  (for/fold ([neg 0.0]
             [extra 0.0])
            ([g gps])
    (values (+ neg (* cost  (car g)))  (+ extra (* (car g) (frag-cost-to frag (cdr g)))))))

(define (cost counts frags)
  (define guards (get-guards))
  (for/fold ([tot 0.0])
            ([(k v) frags]
             #:unless (empty? v))
    (let*-values ([(g) (hash-ref guards k)]
                  [(cost) (frag-cost v k)]
                  [(counter) (hash-ref counts k 0.0)]
                  ;;[(guard-pairs) (guard-counts-indices counts g)]
                  ;;[(neg-cost extra-cost) (calc-neg-extra v guard-pairs cost)]
                  [(neg-cost extra-cost) (values 0 0)]
                  )
      (+ tot (* cost counter) (- neg-cost) extra-cost))))


(define (mult-hash h c)
  (for/hash ([(k v) h])
            (values k (* c v))))


(define (eqns counts frags)
  (define result (make-hash))
  (define adder (lambda (k a b) (+ a b)))
  (define guards (get-guards))
  (for ([(k v) frags]
               #:unless (empty? v))
              (let* ([g (hash-ref guards k)]
                     [counter (hash-ref counts k 0.0)]
                     [eqn (flatten-frag v)]
                     [mult (mult-hash eqn counter )])
                     (printf "eqn: ~a~n" eqn)
                     (printf "count: ~a~n" counter)
                     (printf "mult: ~a~n" mult)
                     (hash-union! result mult #:combine/key adder )))
  result)


(define (instruction-frequency counts frags )
  (define histo (make-hash))
  (for ([(k v) frags])
    (let* ([counter (hash-ref counts k 0)])
      (for ([ins v])
        (hash-set! histo ins (+ counter (hash-ref histo ins 0) )))))
  histo)


(define (missing-traces counts frags)
  (for/hash ([(k v) counts]
             #:unless (hash-has-key? frags k))
    (values k "")))


(define test-trace (reverse '(("jump" . -1) ("setfield_gc" . -1) ("setfield_gc" . -1) ("setfield_gc" . -1) ("setfield_gc" . -1) ("setfield_gc" . -1) ("setfield_gc" . -1) ("setfield_gc" . -1) ("setfield_gc" . -1) ("setfield_gc" . -1))))
