#lang racket

(require "table.rkt")
(require "ex-2.78.rkt")
(require rackunit)

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equ? x y)
  (=(* (numer x) (denom y))
    (* (denom x) (numer y))))

(define (=zero? x)
  (= (numer x) 0))

;; interface to rest of the system
 
(define (tag x) (attach-tag 'rational x))

(put 'add '(rational rational)
     (lambda (x y) (tag (add-rat x y))))

(put 'sub '(rational rational)
     (lambda (x y) (tag (sub-rat x y))))

(put 'mul '(rational rational)
     (lambda (x y) (tag (mul-rat x y))))

(put 'div '(rational rational)
     (lambda (x y) (tag (div-rat x y))))

(put 'make 'rational
     (lambda (n d) (tag (make-rat n d))))

(put 'equ? '(rational rational) equ?)

(put '=zero? '(rational) =zero?)

;; testes

(check-equal? (add-rat (cons 2 3) (cons 1 3)) (cons 1 1))
(check-equal? (sub-rat (cons 2 3) (cons 1 3)) (cons 1 3))
(check-equal? (mul-rat (cons 2 3) (cons 1 3)) (cons 2 9))
(check-equal? (div-rat (cons 2 3) (cons 1 3)) (cons 2 1))
(check-equal? (make-rat 2 3) (cons 2 3))
(check-equal? (equ? (cons 2 3) (cons 2 3)) #t)
(check-equal? (=zero? (cons 0 9)) #t)


