; 1
; a) Write a function to return the n-th element of a list, or NIL if such an element does not exist;

; _n_elem (l0...ln-1 n pos) = 
    ; nil, n-1 = 0
    ; l0, n = pos-1
    ; _n_elem(l1...ln-1, n, pos + 1)

(defun _n_elem (l n pos)
    (cond
        ((null l) nil)
        ((= n pos) (car l))
        (T (_n_elem (cdr l) n (+ pos 1)))
    )
)

(defun n_elem (l n)
    (_n_elem l n 1)
)
(print "a) 5th elem in (1 2 3 4 5 6 7 8 9 10)")
(print (n_elem '(1 2 3 4 5 6 7 8 9 10) '5))

; b) Write a function to check whether an atom E is a member of a list which is not necessarily linear.
; check_atom (l0...ln-1 e) = 
    ; F, n-1 = 0
    ; T, l0 is atom and l0 = e
    ; check_atom(l1...ln-1, e), l0 is atom
    ; check_atom(l0, e) or check_atom(l1...ln-1, e), l0 is list
(defun check_atom (l e)
    (cond 
        ((null l) nil)
        ((and (atom (car l)) (equal (car l) e)) t)
        ((atom (car l)) (check_atom (cdr l) e))
        ((list (car l)) (or (check_atom (car l) e) (check_atom (cdr l) e)))
    )
)

(terpri)
(print "b) check atom 'a' in (1 2 (3 (a 5) (6 7)) 8 (9 10))")
(print (check_atom '(1 2 (3 (a 5) (6 7)) 8 (9 10)) 'a))

; c) Write a function to determine the list of all sublists of a given list, on any level.
;  A sublist is either the list itself, or any element that is a list, at any level. Example:
;  (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 sublists :
;  ( (1 2 (3 (4 5) (6 7)) 8 (9 10)) (3 (4 5) (6 7)) (4 5) (6 7) (9 10) )
; all_sublists (l0...ln-1 e) = 
    ; [], n = 0
    ; appends to original list all the lists generated from all_sublists

(defun all_sublists (l)
    (cond
        ((atom l) nil)
        (T (apply 'append (list l) (mapcar 'all_sublists l))) 
        ;The value returned by MAPCAR is a list of the results of successive calls to function(all_sublists here).
        ; ** no mapcar
    )
)

(terpri)
(print "c) all sublists (1 2 (3 (4 5) (6 7)) 8 (9 10))")
(print (all_sublists '(1 2 (3 (4 5) (6 7)) 8 (9 10))))

; d) Write a function to transform a linear list into a set.
; transform_set (l0...ln-1) = 
    ; [], n-1 = 0
    ; l0 (+) transform_set(remove_appearences(l1...ln-1, l0))
(defun transform_set (l)
    (cond
        ((null l) nil)
        (T (cons (car l) (transform_set (remove_appearences (cdr l) (car l)))))
        ;cons creates a 'fresh' variable, kind of concatenates the following 2 objects
    )
)
; remove_appearences (l0...ln-1, e) = 
    ; [], n-1 = 0
    ; remove_appearences(l1...ln-1, e), l0 = e
    ; l0 (+) remove_appearences(l1...ln-1, e)
(defun remove_appearences (l e)
    (cond
        ((null l) nil)
        ((= (car l) e) (remove_appearences (cdr l) e))
        (T (cons (car l) (remove_appearences (cdr l) e)))
        ;cons creates a 'fresh' variable, kind of concatenates the following 2 objects
    )
)

(terpri)
(print "d) transform list (1 2 3 44 2 4  5 2 3 3 3 3 4 4 5 77) into set")
(print (transform_set '(1 2 3 44 2 4  5 2 3 3 3 3 4 4 5 77)))