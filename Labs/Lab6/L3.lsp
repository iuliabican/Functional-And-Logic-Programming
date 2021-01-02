;  Write a function that computes the sum of even numbers and the decrease the sum of odd numbers,
; at any level of a list.

;---- Auxiliary functions ----
;Math model - compute
;compute(x, total) = 
;   total + x, x is number AND x is even
;   total - x, x is number AND x is odd
;   x, x is non-numerical atom
;    n
;   U  compute(x_i), x is list       
;    i=1
; compute(x - element used in computing, can be either number or list,         
;         total - the total of the computation )   
;Returns: The total of computing alternate sum on a given element

(defun compute (x total)
    (cond
        ((and (numberp x) (evenp x)) (+ total x))
        ((and (numberp x) (oddp x)) (- total x))
        ;((atom x) x)
        (t (apply '+ (mapcar #'(lambda (a) (compute a total)) x)))
    )
)

;(print "Compute total for 1")
;(print (compute 1 0))
;(print "Compute total for 2")
;(print (compute 2 0))
;(print "Compute total for 1 2 3 4")
;(print (compute '(1 2 3 4) 0))

;Math model - compute-all-levels
; compute-all-levels(l1...ln, total) = 
;            compute(l1...ln, total) 
; compute-all-levels(l1...ln - LIST to compute on, total - NUMBER resulted from computing the alternate sum)
;Returns: Computes the alternate sum on the given list, in the given variable 'total'
(defun compute-all-levels(lst total)
    (apply '+ (mapcar #'(lambda (a) (compute a total)) lst))
)

;(print "Compute all for (1 2 (3 4))")
;(print (compute '(1 2 (3 4)) 0))

;---- Main Function ----
;Math model - compute-total
;compute-total(l1...ln) = compute-all-levels(lst, 0)       
; compute-total(l1...ln - LIST to compute alternate sum on)
;Returns: The total of computing alternate sum on the given list
(defun compute-total (lst) (compute-all-levels lst 0))

(terpri)
(print "Compute total for (1 2 (3 4 5) 6 7 8 9 10)")
(print "Expected 5")
(print "Result:")
(print (compute-total '(1 2 (3 4 5) 6 7 8 9 10)))

(terpri)(terpri)

(print "Compute total for (1 2 (3 4 (5)) 6 (7 8) 9 10)")
(print "Expected 5")
(print "Result:")
(print (compute-total '(1 2 (3 4 (5)) 6 (7 8) 9 10)))