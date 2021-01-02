"""
Write a recursive program (Python or C++ programming language) for next requirements. You can use and
extend for implementation the C++/Python model available in /Lab/R1, this model already containing recursive
implementations for creating, printing and destroying of a List.
It is mandatory to work with a structure/class List.
For a List will be used a linked representation. Do not use containers from STL or predefined operations on
lists in Python (append, len, slicing, etc.).

b. Determine the element from the n-th position in a list.
"""


class Node:
    def __init__(self, e):
        self.e = e
        self.next = None


class Lista:
    def __init__(self):
        self.first = None

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
functie pentru determinarea al m-uluia element
Model matematic:
DetMth_rec(l1l2...ln, e, index) = {
    NIL , n=0
    l1 , index=e
    DetMth_rec(l2l3..ln, e, index+1), otherwise
}
'''


def DetMth_rec(lista, m, index):
    if lista.first is None or m < 0 is True:
        return None
    elif m == index:
        element = lista.first.e
        return element
    else:
        return DetMth_rec(lista.sublist(), m, index + 1)


'''
program pentru test
'''


def main():
    lista = createLista()
    m = int(input("Give an m please:"))
    theMthElement = DetMth_rec(lista, m, 1)
    print("The list is:")
    tipar(lista)
    print("The m th element is: " + str(theMthElement))


main()
