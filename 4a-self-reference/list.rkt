;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;;empty list of anything
empty

;; cons in contructor with 2 arguments
;; construct a list with "Flames" on the front of an empty list
;; list of 1 element
(define L1 (cons "Flames" empty)) 

;; construct a list where "Leafs" is the first element and add list to, construct a list in which you add "Flames" to the front of the list empty
;; list of 2 elements
(cons "Leafs" (cons "Flames" empty))

(cons (string-append "alpha" "bet") empty) ;list of 1 string

(define L2 (cons 10 (cons 9 (cons 8 empty)))) ; list of 3 naturals

(define L3 (cons (square 10 "solid" "blue")
                 (cons (triangle 20 "solid" "green")
                       empty)))


(cons (square 10 "solid" "blue")
      ( cons "solid"
             (cons #true
                   (cons 45 empty))))

(first L1) ;produce first element in list
(first L2)
(first L3)

(rest L1) ;produce rest of list (with min 1 element) after first element
(rest L2)
(rest L3)

(first (rest L2)); get 2nd element of list: 1st of rest of list after first element
(first (rest (rest L2))) ;get 3rd element

(empty? L1) ;produce true if argument is empty list
(empty? (rest L1))
(empty? empty)
(empty? 1)

