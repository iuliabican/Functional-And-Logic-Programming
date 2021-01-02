% Model matematic:
% gcd(a, b) =
%	a, b = 0
%	b, a = 0
%	gcd(a % b, b), a >= b
%	gcd(a, b % a), a < b

% gcd(A:number1(int), B:number2(int), R:gcd of number1&number2)
% gcd(i, i, o)

gcd(0, B, B) :- !.
gcd(A, 0, A) :- !.
gcd(A, B, R) :- A > B,
    A1 is A mod B,
    gcd(A1, B, R), !.
gcd(A, B, R) :- A < B,
    B1 is B mod A,
    gcd(A, B1, R), !.
gcd(A, A, A).


% Model matematic:
% lcm(a, b) =
%        0, b=0
%        a * b / gcd(a, b), otherwise

% lcm([H|T]:list to be used, LLCM:(number)the lcm over the given list);
% lcm(i, o)

lcm([],1):-!.
lcm([H|T], LLCM) :-
    lcm(T, LCM),
    gcd(H, LCM, GCD),
    LLCM is (abs(H * LCM) / GCD).

