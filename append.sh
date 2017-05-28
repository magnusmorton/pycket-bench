for f in *.rkt; do
    echo "\n(require \"cost.rkt\")\n(define eqns (equations))\n(fprintf (current-error-port) \"eqns: ~a,~a,~a,~a,~a,~a~n\" (hash-ref eqns 0) (hash-ref eqns 1) (hash-ref eqns 2) (hash-ref eqns 3) (hash-ref eqns 4) (hash-ref eqns 5))" >> $f
done
