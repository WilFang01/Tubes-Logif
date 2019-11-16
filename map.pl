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
    NewP is P-5,
    NewL is L-5,
    random(NewP,P,X1),
    random(NewL,L,Y1),
    random(NewP,P,X2),
    random(NewL,L,Y2),
    asserta(legendary1(X1,Y1)),
    asserta(legendary2(X2,Y2)).

isPlayer(X,Y) :-
    positionX(A),
    positionY(B),
    X =:= A,
    Y =:= B.

isGym(X,Y) :-
    cure(_),
    X =:= 2,
    Y =:= 2.

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
    NewJ is J-6,
    NewL is L-6,
    random(3,NewJ,TempX1),
    random(3,NewJ,TempX2),
    random(3,NewJ,TempX3),
    random(3,NewJ,TempX4),
    random(3,NewJ,TempX5),
    random(3,NewJ,TempX6),
    random(3,NewJ,TempX7),
    random(3,NewJ,TempX8),
    random(3,NewL,TempY1),
    random(3,NewL,TempY2),
    random(3,NewL,TempY3),
    random(3,NewL,TempY4),
    random(3,NewL,TempY5),
    random(3,NewL,TempY6),
    random(3,NewL,TempY7),
    random(3,NewL,TempY8),
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
    asserta(positionX(1)),
    asserta(positionY(1)).

map :- 
    init(_),
    adaTembok(_),
    printX(0,0),!.