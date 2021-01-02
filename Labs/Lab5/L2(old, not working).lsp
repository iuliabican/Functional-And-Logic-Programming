;  9. Convert a tree of type (1) to type (2).
; As an example, the tree
;   A
;  / \
; B   C
;    / \
;   D   E  is represented as follows:
;
; (A 2 B 0 C 2 D 0 E 0) (1)
; (A (B) (C (D) (E))) (2)

;   A
;  / \
; B   C
;  \   \
;   D   E

; (A 2 B 1 D 0 C 1 E 0)
; (A (B (D)) (C (E)))

( defun convert-tree(l)
    (cond
        ((null l) nil)
        ((= cadr 2) (list (car l) (list (convert-tree(cadr l)))))
        ((= cadr 1) (list (car l) (list (convert-tree(cadr l)))))
        ((= cadr 0) (list (car l)) convert-tree(cddr l))
    )
)

(terpri)
(print "Transform type(1) to type(2) for (A 2 B 0 C 2 D 0 E 0)")
(print "Expected (A (B) (C (D) (E)))")
(print (convert-tree '(A 2 B 0 C 2 D 0 E 0)))
