% 2. Are given n points in a plan (represented using its coordinates).
% Write a predicate to determine all subsets of collinear points.

determinant([XA, YA], [XB, YB], [XC, YC], Rez):-
    Rez is XA * (YB - YC) + XB * (YC - YA) + XC * (YA - YB).


% col(l1l2...ln) = True, for n = 0, n=1 & n=2
%                       col(l2..ln), if n>=3 , determinant(l1,l2,l3)=0

% col(L:list)
% col(i)

col([]).
col([_]).
col([_, _]).
col([H1, H2, H3 | T]):-
    determinant(H1, H2, H3, Determinant),
    Determinant =:= 0,
    col([H2, H3 | T]).

% generate_subset(l1l2...ln) =
%           1. [], for n = 0
%           2. col(generate_subset(l2..ln)), n>=1
%           3. l1 (+) col(generate_subset(l2...ln)), n>=1

% generate_subset(L:list, R:List)
% generate_subset(i, o)

generate_subset([], []).
generate_subset([_ | T], Rez):-
    generate_subset(T, Rez),
    col(Rez).
generate_subset([H | T], [H | Rez]):-
    generate_subset(T, Rez),
    col([H | Rez]).
