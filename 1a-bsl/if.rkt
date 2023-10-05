;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname if) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;true
;false

(define WIDTH  100)
(define HEIGHT 100)

(> WIDTH HEIGHT)
(>= WIDTH HEIGHT)

;compare 2 numbers with predicates = or >
;(= 1 2)
;(= 1 1)
;(> 3 9)

;(/ 3 4)
;(round (/ 3 4))
;(round 12.5)
;(round 13.5)

;compare strings with predicate string=?
(string=? "foo" "bar")

;which image is thinner: I1 with image width 10
(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 20 10 "solid" "blue"))
(< (image-width I1)
   (image-width I2))

; if <question/predicate> <expression-if-true> <expression-if-false>
(if (< (image-width I2)
       (image-height I2))
    "tall"
    "wide")

; check if image 1 is taller and skinnier
(and (> (image-height I1) (image-height I2))
     (< (image-width I1) (image-width I2)))