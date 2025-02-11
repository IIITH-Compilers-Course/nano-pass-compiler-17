#lang racket
(require "../utilities.rkt")
(require "../custom_utilities.rkt")
(require data/queue)
(require graph)

(provide uncover-live)

(define blocks '())

(define (analyze_dataflow G transfer bottom join)
  (define mapping (make-hash))
  (for ([v (in-vertices G)])
    (dict-set! mapping v bottom))
  (define worklist (make-queue))
  (for ([v (in-vertices G)])
    (enqueue! worklist v))
  (define trans-G (transpose G))
  (while (not (queue-empty? worklist))
         (define node (dequeue! worklist))
         (define input
           (for/fold ([state bottom]) ([pred (in-neighbors trans-G node)])
             (join state (dict-ref mapping pred))))
         (define output (transfer node input))
         (cond
           [(not (equal? output (dict-ref mapping node)))
            (dict-set! mapping node output)
            (for ([v (in-neighbors G node)])
              (enqueue! worklist v))]))
  mapping)

(define (transfer label live-after)
  (match (dict-ref blocks label)
    [(Block info instrlist)
     (define live-vars (get-live-vars instrlist))
     (define new-info (dict-set info 'live-vars (cdr live-vars)))
     (set! blocks (dict-set blocks label (Block new-info instrlist)))
     (dict-set! labels->live label (car live-vars))
     (car live-vars)]))

(define (uncover-live-defs def)
  (match def
    [(Def name params rtype info blocks-cfg)
     (set! blocks blocks-cfg)
     (define trans-G (transpose (dict-ref info 'cfg)))
     (define temp (make-hash))
     (for ([v (in-vertices trans-G)])
       (dict-set! temp v (set)))
     (dict-set! temp (symbol-append name 'conclusion) (set 'rax 'rsp))
     (custom-live-labels-set! temp)
     (analyze_dataflow trans-G transfer (set) set-union)
     (Def name params rtype (dict-set info 'labels->live labels->live) blocks)]))

(define (uncover-live p)
  (match p
    [(ProgramDefs info defs) (ProgramDefs info (map uncover-live-defs defs))]))
