:- dynamic(lebar/1).
:- dynamic(panjang/1).
:- dynamic(positionX/1).
:- dynamic(positionY/1).
:- dynamic(tembok/16).
:- dynamic(adaTembok/1).
:- dynamic(legendary1/2).
:- dynamic(legendary2/2).

initLegendaryMap :-
    lebar(L),
    panjang(P),
    random(5,10,X1),
    random(5,10,Y1),
    random(10,P,X2),
    random(10,L,Y2),
    asserta(legendary1(X1,Y1)),
    asserta(legendary2(X2,Y2)).

isPlayer(X,Y) :-
    positionX(A),
    positionY(B),
    X =:= A,
    Y =:= B.

isGym(X,Y) :-
    cure(_),
    X =:= 4,
    Y =:= 9.

isLegendary1(X,Y) :-
    legendary1(A,B),
    X =:= A,
    Y =:= B.

isLegendary2(X,Y) :-
    legendary2(A,B),
    X =:= A,
    Y =:= B.

generateTembok :-
    asserta(adaTembok(1)),
    lebar(L),
    panjang(J),
    random(6,J,TempX1),
    random(6,J,TempX2),
    random(6,J,TempX3),
    random(6,J,TempX4),
    random(6,J,TempX5),
    random(6,J,TempX6),
    random(6,J,TempX7),
    random(6,J,TempX8),
    random(6,L,TempY1),
    random(6,L,TempY2),
    random(6,L,TempY3),
    random(6,L,TempY4),
    random(6,L,TempY5),
    random(6,L,TempY6),
    random(6,L,TempY7),
    random(6,L,TempY8),
    asserta(tembok(TempX1,TempY1,TempX2,TempY2,TempX3,TempY3,TempX4,TempY4,TempX5,TempY5,TempX6,TempY6,TempX7,TempY7,TempX8,TempY8)).

isTembok(X1,Y1,X2,Y2,X3,Y3,X4,Y4,X5,Y5,X6,Y6,X7,Y7,X8,Y8) :-
    tembok(TempX1,TempY1,TempX2,TempY2,TempX3,TempY3,TempX4,TempY4,TempX5,TempY5,TempX6,TempY6,TempX7,TempY7,TempX8,TempY8),
    (
        (
        X1 == TempX1,
        Y1 == TempY1
        );
        (
            X2 == TempX2,
            Y2 == TempY2
        );
        (
            X3 == TempX3,
            Y3 == TempY3
        );
        (
            X4 == TempX4,
            Y4 == TempY4
        ); 
        (   
            X5 == TempX5,
            Y5 == TempY5
        );
        (
            X6 == TempX6,
            Y6 == TempY6
        );
        (   
            X7 == TempX7,
            Y7 == TempY7
        );
        (   
            X8 == TempX8,
            Y8 == TempY8
        )
    ).

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
    isTembok(X,Y,X,Y,X,Y,X,Y,X,Y,X,Y,X,Y,X,Y),
    write('X'),
    NextX is (X+1),
    printX(NextX,Y).

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
    isLegendary1(X,Y),
    write('L'),
    NextX is (X+1),
    printX(NextX,Y).

printX(X,Y) :-
    isLegendary2(X,Y),
    write('L'),
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

initMap(X, Y) :-
    asserta(lebar(X)),
    asserta(panjang(Y)).

initPlayer :-
    asserta(cure(1)),
    random(1,5,A),
    random(1,5,B),
    asserta(positionX(A)),
    asserta(positionY(B)).

map :- 
    init(_),
    adaTembok(_),
    printX(0,0),!.