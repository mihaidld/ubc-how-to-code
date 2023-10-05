;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname img) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;(circle 10 "solid" "red")
;(circle 10 "outline" "green")
;(rectangle 5 15 "outline" "blue")

;image of string "hello" of font size 24 not the string
;(text "hello" 24 "orange")

;produce image with all arguments stacked up and ligned up on their horizontal centers 

(above (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))

;produce image with all arguments side by side and ligned up on their vertical centers 
(beside (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))

;produce image with all arguments one on top of the other and ligned up on their centers 
(overlay (circle 10 "solid" "red")
         (circle 20 "solid" "yellow")
         (circle 30 "solid" "green"))

(triangle 40 "solid" "purple")
