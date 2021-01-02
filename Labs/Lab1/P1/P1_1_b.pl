% Model matematic:
% insert_pow_2(l1...ln, v, pos, index) =
%	[], n = 0
%	l1 + v + insert_pow(l2...ln, v, pos * 2, index + 1), pos = index
%	l1 + insert_pow(l2...ln, v, pos, index + 1), pos != index

% insert_pow_2(L:list in which to insert, V:number/value to insert,
% POS:number-position to insert after, INDEX:number-goes through the
% list, R:(resulted)list)
% insert_pow_2(i, i, i, i, o)

insert_pow_2([], _, _, _, []).
insert_pow_2([H|T], V, POS, INDEX, [H, V|R]) :- POS =:= INDEX,
    New_pos is POS * 2,
    New_index is INDEX + 1,
    insert_pow_2(T, V, New_pos, New_index, R).
insert_pow_2([H|T], V, POS, INDEX, [H|R]) :- POS =\= INDEX,
    New_index is INDEX + 1,
    insert_pow_2(T, V, POS, New_index, R).

% insert(L:list to insert in, V:(number)value to insert exp, *2,
% R:resulting list)
% insert(i, i, o)

insert(L, V, R) :- insert_pow_2(L, V, 1, 1, R).

