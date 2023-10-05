;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname maze) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Data definitions 

(define-struct junction (left straight right))
       
;; Maze is one of:
;; - false
;; - "finish"
;; - (make-junction Maze Maze Maze)
;; a maze where at each junction you can either go straight, left or right. 
;; false means dead end, "finish" means you've reached the end of the maze
(define M0 false)      ; a maze that is a dead end
(define M1 "finish")   ; a maze where you are already at the finish
(define M2 (make-junction
            (make-junction false 
                           (make-junction false
                                          false 
                                          (make-junction false
                                                         false 
                                                         false))
                           (make-junction false
                                          (make-junction (make-junction false
                                                                        false 
                                                                        false)
                                                         (make-junction false 
                                                                        "finish"
                                                                        false)
                                                         false)
                                          false))
            (make-junction false 
                           false 
                           (make-junction false
                                          false
                                          false))
            false))    ; a maze

(define (fn-for-maze m)
  (cond[(false? m) (...)]
       [(and (string? m) (string=? m "finish")) (...)]
       [else (... (fn-for-maze (junction-left m))
                  (fn-for-maze (junction-straight m))
                  (fn-for-maze (junction-right m)))]))

;; Functions

;; Maze -> ListOfString or false
;; produce list with instructions to get to finish or empty if no solution
(check-expect (solution false) false)
(check-expect (solution "finish") empty)
(check-expect (solution (make-junction false "finish" false)) (list "straight"))
(check-expect (solution (make-junction (make-junction false
                                                      false 
                                                      false)
                                       (make-junction "finish"
                                                      false
                                                      false)
                                       false))
              (list "straight" "left"))
(check-expect (solution M2)
              (list "left" "right" "straight" "straight" "straight"))

;(define (solution m) empty) ;stub

;<template from Maze>

(define (solution m)
  (cond[(false? m) false]                                               ;if we reached false produce false dead end        
       [(and (string? m) (string=? m "finish")) empty]                  ;if we reach "finish" produce empty list, we are there already
       [else (cond [(not (false? (solution (junction-left m))))         ;check going left: if we don't get false it means it's the good path so construct list with "left" on front of that list
                    (cons "left" (solution (junction-left m)))]       
                   [(not (false? (solution (junction-straight m))))
                    (cons "straight" (solution (junction-straight m)))]
                   [(not (false? (solution (junction-right m))))
                    (cons "right" (solution (junction-right m)))]
                   [else false])]))                                     ;there are places where we go next to left, straight and right produce all three false (dead ends)