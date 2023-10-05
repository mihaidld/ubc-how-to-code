;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname compound) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; define structure pos with fields x and y to store coordinates
(define-struct pos (x y))
;; this definition makes 3 more definitiosn behind the scenes:
;; - constructor: make-pos (make-<struct name>)
;; - one selectors for each field: pos-x and pos-y (<struct name>-<field name>)
;; - predicate pos? (<struct name>?)

(define P1 (make-pos 3 6)) ;constructor: produces pos structure with x value 3 and y 6
(define P2 (make-pos 2 8))
P1
P2

(pos-x P1)                 ;selectors
(pos-y P2)

(pos? P1)                  ;predicate
(pos? "hello")