:- dynamic(lebar/1).
:- dynamic(panjang/1).
:- dynamic(positionX/1).
:- dynamic(positionY/1).


isPlayer(X,Y) :-
    positionX(A),
    positionY(B),
    X =:= A,
    Y =:= B.

isGym(X,Y) :-
    X =:= 20,
    Y =:= 20.

isAtas(_,Y) :-
    Y =:= 0.

isBawah(_,Y) :-
    lebar(L),
    Max is L+1,
    Y =:= Max.

isKiri(X,_) :-
    X =:= 0.

isKanan(X,_) :-
    panjang(P),
    Max is P+1,
    X =:= Max.

printX(X,Y) :-
    isBawah(X,Y),
    isKanan(X,Y),
    write('X').
    
printX(X,Y) :-
    isPlayer(X,Y),
    write('P'),
    NextX is (X+1),
    printX(NextX,Y).

printX(X,Y) :-
    isGym(X,Y),
    write('G'),
    NextX is (X+1),
    printX(NextX,Y).

printX(X,Y) :-
    isBawah(X,Y),
    write('X'),
    NextX is (X+1),
    printX(NextX,Y).

printX(X,Y) :-
    isKiri(X,Y),
    write('X'),
    NextX is (X+1),
    printX(NextX,Y).

printX(X,Y) :-
    isKanan(X,Y),
    write('X'),nl,
    NextX is 0,
    NextY is (Y+1),
    printX(NextX,NextY).

printX(X,Y) :-
    isAtas(X,Y),
    write('X'),
    NextX is (X+1),
    printX(NextX,Y).

printX(X,Y) :-
    \+isKiri(X,Y),
    \+isKanan(X,Y),
    \+isBawah(X,Y),
    \+isAtas(X,Y),
    write('-'),
    NextX is (X+1),
    printX(NextX,Y).

initMap(X,Y) :-
    asserta(lebar(Y)),
    asserta(panjang(X)).

initPlayer(X,Y) :-
    asserta(positionX(X)),
    asserta(positionY(Y)).

showMap :- printX(0,0),!.