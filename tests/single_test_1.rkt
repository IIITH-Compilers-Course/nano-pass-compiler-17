; (let ([t (vector 40 #t (vector 2))]) (if (vector-ref t 1)
;          (+ (vector-ref t 0)
;             (vector-ref (vector-ref t 2) 0))
; 44))

;;;  (let ([v1 (vector 1 2 3)])
;;;      (let ([v2 (vector 3 4 5)])
;;;      (+ (vector-ref v1 0) (vector-ref v2 0))))
;;; (if (> 1 2) (+ 1 2) (+ 3 4))

;;; (let ([v (vector 1 20 30 40 1)])
;;;     (begin
;;;         (vector-set! v 4 2)
;;;         (+ (vector-ref v 3) (vector-ref v 4))))

;;; (let ([v (vector 42)])
;;;     (if (< (vector-length v) 2) 5 10))

;;; (let ([v (vector 1 2)]) 42)

;;;  (define (id [x : Integer]) : Integer
;;;  (if (> x 1) x x))
;;;  (id 42)

;  (define (id [x : Integer]) : Integer x)
;  (id 42)

; (define (id [a : Integer] [b : Integer] [c : Integer] [d : Integer] [e : Integer] [f : Integer] [g : Integer] [h : Integer]) : Integer (
;     + h
;         (- b
;             (+ c
;                 (+ d
;                     (- e
;                         (+ f
;                             (- g a))))))
;  ))
;  (id 1 2 3 4 5 6 20 1)

; (define (fun [a : Integer] [b : Integer]) : Integer (+ a b))
; (fun 1 2)
;;; (define (map [f : (Integer -> Integer)] [v : (Vector Integer Integer)])
;;;   :
;;;   (Vector Integer Integer)
;;;   (vector (f (vector-ref v 0)) (f (vector-ref v 1))))

;;; (define (inc [x : Integer])
;;;   :
;;;   Integer
;;;   (+ x 1))

;;; (vector-ref (map inc (vector 0 41)) 1)
;  (define (id [a : Integer] [b : Integer] [c : Integer] [d : Integer] [e : Integer] [f : Integer] [g : Integer] [h : Integer]) : Integer (
;     + a
;         (+ b
;             (+ c
;                 (+ d
;                     (+ e
;                         (+ f
;                             (+ g h))))))
;  ))
;  (id 1 2 3 4 5 6 20 1)

;;; (let ([x 10]) (let ([y (+ x 10)]) (let ([x (+ y x)]) (+ x y))))

;;; (define (id [x : Integer])
;;;   :
;;;   Integer
;;;   x)
;;; (id 42)


(define (mult [a : Integer] [b : Integer])
    : Integer
    (let ([x a]) 
        (begin 
            (while (> b 1)
                (begin
                (set! x (+ x a))
                (set! b (- b 1))))
        x)))

(define (factorial [n : Integer])
    : Integer
    (if (eq? n 1)
        1
        (mult (factorial (- n 1)) n)))

(factorial 2)