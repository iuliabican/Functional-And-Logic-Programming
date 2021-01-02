;  9. Convert a tree of type (1) to type (2).
; As an example, the tree
;   A                                          A
;  / \                                        / \
; B   C                                      B   C
;    / \                                      \   \
;   D   E  is represented as follows:          D   E
;
; (A 2 B 0 C 2 D 0 E 0) (1)                 (A 2 B 1 D 0 C 1 E 0)
; (A (B) (C (D) (E))) (2)                   (A (B (D)) (C (E)))

;---- Auxiliary functions ----
;Math model - traversal-left
;traversal-left(l1...ln, nv, nm) = 
;   [], n=0
;   ([], l1...ln), nv = nm+1
;   (l1 U l2 U Left U Right) 
; Notations:
;   LRpair = (Left, Right), where:
;           Left  = car(traversal_left(l3...ln, nv+1, l2 + nm))
;           Right = cadr(traversal_left(l3...ln, nv+1, l2 + nm)))        
; traversal_left(l1...ln - LIST of the second level until the leaves of a tree(T2), 
;                nv      - NUMBER vertices, 
;                nm      - NUMBER "edges")   
;Returns: a list of left subtree and right subtree separated like ((Lsubtree)(Rsubtree))

(defun traversal_left(arb nv nm)
    (cond
        ((null arb) nil)
        ((= nv(+ 1 nm)) (list nil arb)) 
        (t 
            ((lambda (trees) (list (cons (car arb) (cons (cadr arb) (car trees))) (cadr trees))) 
                (traversal_left (cddr arb) (+ 1 nv) (+ (cadr arb) nm)))
        )
        ;(t ((lambda (trees) (list (cons (car arb (cons (cadr arb (car trees)))) (cadr trees))))(traversal_left (cddr arb) (+ 1 nv) (+(cadr arb)nm))))
    )
)

;Math model - left
;left_right(l1...ln) = traversal_left(l1...ln, 0, 0) 
; left_right(l1...ln - LIST of the second level until the leaves of a tree, written in type(2)))
;Returns: a list of left subtree and right subtree separated like "((Lsubtree)(Rsubtree))"
(defun left_right(l)
    (traversal_left (cddr l) 0 0)
)

;---- Main Function ----
;Math model - convert-tree
;convert-tree(l1...ln) = 
;   [], n=0
;   l1 U convert-tree(car left_right(l)) U convert-tree(cadr left_right(l)), if l2 = 2
;   l1 U convert-tree(car left_right(l)), if l2 = 1
;   l1, if l2 = 0
; convert-tree(l1...ln - LIST which consists of a tree in type(1) representation)
;Returns: a list representing a tree, written in type(2) 
( defun convert-tree(l)
    (cond
        ((null l) nil)
        ((= (cadr l) 2) (list (car l) (convert-tree (car (left_right l))) (convert-tree (cadr (left_right l)))))
        ((= (cadr l) 1) (list (car l) (convert-tree (car (left_right l)))))
        ((= (cadr l) 0) (list (car l)))
        ;(t (list (car l) (convert-tree (car (left_right l))) (convert-tree (cadr (left_right l)))))
    )
)

(terpri)
(print "Transform type(1) to type(2) for (A 2 B 0 C 2 D 0 E 0)")
(print "Expected (A (B) (C (D) (E)))")
(print "Result:")
(print (convert-tree '(A 2 B 0 C 2 D 0 E 0)))
(terpri)(terpri)
(print "Transform type(1) to type(2) for GIVEN EXAMPLE:")
(print "Input:     (A 2 B 2 D 0 E 1 H 0 C 2 F 1 I 0 G 0)")
(print "Expected:  (A (B (D) (E (H))) (C (F (I)) (G)))")
(print "Result:")
(print (convert-tree '(A 2 B 2 D 0 E 1 H 0 C 2 F 1 I 0 G 0)))
;----Extra things I tried/brainstormed----
;(print (left '(A 2 B 0 C 2 D 0 E 0)))
;lambda - transformation
;((list (cons (car arb) (cons (cadr arb) (car (traversal_left (cddr arb) (+ 1 nv) (+ (cadr arb) nm))))) 
;        (cadr (traversal_left (cddr arb) (+ 1 nv) (+ (cadr arb) nm)))))
; let - idea
; (let ((trees (traversal_left (cddr arb) (+ 1 nv) (+ (cadr arb) nm)))) (....) )