"""
Write a recursive program (Python or C++ programming language) for next requirements. You can use and
extend for implementation the C++/Python model available in /Lab/R1, this model already containing recursive
implementations for creating, printing and destroying of a List.
It is mandatory to work with a structure/class List.
For a List will be used a linked representation. Do not use containers from STL or predefined operations on
lists in Python (append, len, slicing, etc.).

a. Substitute all occurrences of an element from a list with another list.
"""
import copy


class Node:
    def __init__(self, e):
        self.e = e
        self.next = None


class Lista:
    def __init__(self):
        self.first = None

    def isEmpty(self):
        return self.first is None

    def emptyList(self):
        new_list = Lista()
        return new_list

    def addFirst(self, e):
        new_element = Node(e)
        new_element.next = self.first
        self.first = new_element
        return self

    def firstElem(self):
        return self.first.e

    def sublist(self):
        sublistt = Lista()
        sublistt.first = self.first.next
        return sublistt


'''
crearea unei liste din valori citite pana la 0
'''


def createLista():
    lista = Lista()
    lista.first = createLista_rec()
    return lista


def createLista_rec():
    x = int(input("x="))
    if x == 0:
        return None
    else:
        node = Node(x)
        node.next = createLista_rec()
        return node


'''
tiparirea elementelor unei liste
'''


def tipar(lista):
    tipar_rec(lista.first)


def tipar_rec(nod):
    if nod != None:
        print(nod.e)
        tipar_rec(nod.next)


'''
---------------------------------------------------------------------
'''

'''
Overall Mathematical Model:
15a_rec(l1l2...ln, p1p2...pm, e) = {
    NIL, n = 0 or e < 0
    p1..pn U 15a_rec(l2l3..ln, p1..pm, e), l1 = e,
    l1 U 15a_rec(l2l3..ln, p1..pm, e), otherwise 
}
'''




'''
functie pentru a adăuga lista 'l' la începutul listei L
*Un fel de model matematic:
addAtBeginning(l1l2...ln, p1p2...pm) = {
    NIL, n=0 and m=0
    addFirst(addAtBeginning(l2l3..ln, p1p2...pm),l1), m=0  
    addFirst(addAtBeginning(l1l2..ln, p2p3...pm),p1), otherwise
}
'''
def addAtBeginning(L, l):
    if l.isEmpty() and L.isEmpty():
        return l.emptyList()
    elif l.isEmpty():
        return addAtBeginning(L.sublist(), l).addFirst(L.firstElem())
    else:
        return addAtBeginning(L, l.sublist()).addFirst(l.firstElem())

'''
functie care substituie fiecare aparitie a elementului e in lista cu lista initiala (initial)
*Un fel de model matematic:
substitute_rec(l1l2...ln, e, p1p2...pm) = {
    NIL, n=0
    addAtBeginning(substitute_rec(l2l3..ln, e, p1p2...pm), p1p2...pm), l1=e
    addFirst(substitute_rec(l2l3..ln, e, p1p2...pm),l1), otherwise
}
'''


def substitute_rec(lista, e, initial):
    if lista.isEmpty():
        return lista.emptyList()
    elif lista.firstElem() == e:
        return addAtBeginning(substitute_rec(lista.sublist(), e, initial), initial)
    else:
        return substitute_rec(lista.sublist(), e, initial).addFirst(lista.firstElem())


'''
---------------------------------------------------------------------
list to test on -> 1,2,3,2,
'''

'''
program pentru test
'''


def main():
    lista = createLista()
    m = int(input("Give an m please:"))
    print("The edited list is: ")
    tipar(substitute_rec(lista, m, lista))


main()
