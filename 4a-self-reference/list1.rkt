;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname list1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(cons "a" (cons "b" (cons "c" empty)))

(list "a" "b" "c")

(list (+ 1 2) (+ 3 4) (+ 5 6))

(define L1 (list "b" "c"))
(define L2 (list "d" "e" "f"))

;; To add one element to list we need cons
(cons "a" L1) ;produce new list by adding "a" to the front of the value of L1 (list "a" "b" "c")

;;To fully form one list at once when we know all elements use list
;;List element can be another list
(list "a" L1) ;produce new list with "a" as first element and L1 as second element (list "a" (list "b" "c"))
(list L1 L2)

(append L1 L2) ;combines two or more lists. Creates a single list from several, by concatenation of the items.