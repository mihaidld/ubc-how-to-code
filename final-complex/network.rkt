;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname network) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))


;  PROBLEM 1:
;
;  Consider a social network similar to Twitter called Chirper. Each user has a name, a note about
;  whether or not they are a verified user, and follows some number of people.
;
;  Design a data definition for Chirper, including a template that is tail recursive and avoids
;  cycles.
;
;  Then design a function called most-followers which determines which user in a Chirper Network is
;  followed by the most people.
;

;; Data definitions

(define-struct user (name verified following))
;; User is (make-user String Boolean (listof User)
;; interpr. a user with their name, whether or not they are a verified user, and list of users he follows

;; Network is (listof User)
;; interpr. a network of users interconnected or not
;;          A user in a network can exist without being followed by anybody and following nobody,
;;          There can users inside network interconnected (users following each other) inside a subnetwork, but users from different subnetorks not interconnected

(define N1 (shared ((-A- (make-user "A" true (list -B-)))         ;network of 2 users where verified A follows unverified B, but B follows nobody
                    (-B- (make-user "B" false empty)))
             (list -A- -B-)))
(define N2 (shared ((-C- (make-user "C" true (list -D-)))         ;network of 3 users where D has 2 followers
                    (-D- (make-user "D" false (list -C-)))
                    (-E- (make-user "E" false (list -D-))))
             (list -C- -D- -E-)))
(define N3 (append N1 N2))                                        ;network with 2 subnetworks, where D has most followers (2)
(define N4  (shared ((-A- (make-user "A" true (list -B- -D-)))
                     (-B- (make-user "B" false (list -C- -E-)))
                     (-C- (make-user "C" true (list -B-)))
                     (-D- (make-user "D" true (list -E-)))
                     (-E- (make-user "E" false (list -F- -A-)))
                     (-F- (make-user "F" false (list)))
                     (-G- (make-user "G" false (list -E-))))
              (list -A- -B- -C- -D- -E- -F- -G-)))                ;network of 7 users where nobody follows G and H, but B is followed by most users (A, C, G)


;; template: structural recursion, encapsulate w/ local, tail-recursive w/ worklist, 
;;           context-preserving accumulator what rooms have we already visited

#;
(define (fn-for-user u0)
  ;; todo is (listof User); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of users already visited
  (local [(define (fn-for-user u todo visited) 
            (if (member (user-name u) visited)
                (fn-for-lou todo visited)
                (fn-for-lou (append (user-following u) todo)
                            (cons (user-name u) visited)))) ; (... (user-name u) (user-verified u))
          (define (fn-for-lou todo visited)
            (cond [(empty? todo) (...)]
                  [else
                   (fn-for-user (first todo) 
                                (rest todo)
                                visited)]))]
    (fn-for-user u0 empty empty)))

;; template for arbitrary sized data
#;
(define (fn-for-lou lou)
  (cond [(empty? lou) (...)]
        [else (...
               (fn-for-user (first lou))
               (fn-for-lou (rest lou)))]))


;; Network -> User
;; produces the user in given network which is followed by the most users
;; ASSUME: network has at least 1 user
(check-expect (most-followers N1) (shared ((-A- (make-user "A" true (list -B-)))
                                           (-B- (make-user "B" false empty)))
                                    -B-)); B has 1 follower (A)
(check-expect (most-followers N2) (shared ((-C- (make-user "C" true (list -D-)))       
                                           (-D- (make-user "D" false (list -C-)))
                                           (-E- (make-user "E" false (list -D-))))
                                    -D-)); D has 2 followers
(check-expect (most-followers N3) (most-followers N2)); same D from subnetwork N2
(check-expect (most-followers N4) (shared ((-A- (make-user "A" true (list -B- -D-)))
                                           (-B- (make-user "B" false (list -C- -E-)))
                                           (-C- (make-user "C" true (list -B-)))
                                           (-D- (make-user "D" true (list -E-)))
                                           (-E- (make-user "E" false (list -F- -A-)))
                                           (-F- (make-user "F" false (list)))
                                           (-G- (make-user "G" false (list -E-)))) 
                                    -E-)); B is followed by most users (B, D, G)

;(define (most-followers n) (first n)) ;stub

(define (most-followers n)
  ;; rsf is (listof Details); list of user details, each element has the room and count of followers this user has so far
  (local[(define-struct details (user cnt))
         ;; Details is (make-details User Natural)
         ;; interpr. user details with room and count of followers

         (define (fn-for-lou lou rsf)             ;(listof User) (listof Details) -> User
           (cond [(empty? lou) (max-cnt rsf)]                                          ;when reached end produce User resulted from wished for max-cnt 
                 [else (fn-for-lou (rest lou)                                          ;NR on (rest lou) 
                                   (increase-cnts (user-following (first lou)) rsf))]));updated rsf with increased counts for users followed by (first lou)
         
         ;;       lou        empty     (cons U LOU)
         ;;lod
         ;; empty            lod (1)   (map <make-details for user with cnt 1> lou) (2)
         ;;
         ;;(cons D LOD)      lod (1)    <if first user in lod is in lou> (3)
         ;;                             update its count on top of NR (lou with user removed) (rest lod)
         ;;                             NR lou (rest lod)

         ;;template 2 one of
         ;; 4 cases simplified to 3
         (define (increase-cnts lou lod) ;(listofUser) (listof Details) -> (listof Details); produce updated lod with cnt incremented for users in lou                        
           (cond [(empty? lou) lod]                                                    ;(1)
                 [(empty? lod) (map (λ (u) (make-details u 1)) lou)]                   ;(2)
                 [else (if (member (details-user (first lod)) lou)                     ;(3) if user in (first lod) in lou
                           (cons (make-details (details-user (first lod))
                                               (add1 (details-cnt (first lod))))       ;cons updated details on top of NR
                                 (increase-cnts (remove (details-user (first lod)) lou)
                                                (rest lod)))
                           (increase-cnts lou (rest lod)))]))                          ;else NR full lou and (rest lod)

         (define (max-cnt lod0)                 ;(listof Details) -> User; produce details of user associated with maximum cnt as an element of lod                                 
           ;; max-rsf if Details; a result so far accumulator for user with maximum number of followers
           (local [(define (max-cnt lod max-rsf)
                     (cond [(empty? lod) (details-user max-rsf)]
                           [else (if (> (details-cnt (first lod)) (details-cnt max-rsf))
                                     (max-cnt (rest lod) (first lod))                  ;update max-rsf
                                     (max-cnt (rest lod) max-rsf))]))]
             (max-cnt lod0 (first lod0))))]                                            ;initialize max-rsf to first element

    (fn-for-lou n empty)))                                                             ;trampoline calls fn-for-lou with network and rsf accumulator initially empty
