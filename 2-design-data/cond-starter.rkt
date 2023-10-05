;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cond-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; cond-starter.rkt

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 20 20 "solid" "red"))
(define I3 (rectangle 20 10 "solid" "red"))

;; Image -> String
;; produce shape of image, one of "tall", "square" or "wide"
(check-expect (aspect-ratio I1) "tall")
(check-expect (aspect-ratio I2) "square")
(check-expect (aspect-ratio I3) "wide")

;(define (aspect-ratio img) "")  ;stub

;(define (aspect-ratio img)      ;template
;  (... img))

#;
(define (aspect-ratio img)  
  (if (> (image-height img) (image-width img))
      "tall"
      (if (= (image-height img) (image-width img))
          "square"
          "wide")))

(define (aspect-ratio img)
  (cond [(> (image-height img) (image-width img)) "tall"]
        [(= (image-height img) (image-width img)) "square"]
        [else "wide"]))

;; Evaluation rules
(cond [(> 1 2) "bigger"]
      [(= 1 2) "equal"]
      [(< 1 2) "smaller"])

;if there are no question/answer pairs signal an error
;if question in first pair doesn't evaluate to boolean or is "else" signal error
;evaluation question to value in first question/answer pair
(cond [false "bigger"]
      [(= 1 2) "equal"]
      [(< 1 2) "smaller"])

;since first question is false, drop first question/answer pair
(cond [(= 1 2) "equal"]
      [(< 1 2) "smaller"])

;evaluation question to value in first question/answer pair
(cond [false "equal"]
      [(< 1 2) "smaller"])

;since first question is false, drop first question/answer pair
(cond [(< 1 2) "smaller"])

;evaluation question to value in first question/answer pair
(cond [true "smaller"])

;if first question is true or else replace entire cond expression with first answer
"smaller"