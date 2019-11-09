:- dynamic(cure/1).

:- include('tokemon.pl').
:- include('map.pl').

s :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    \+isAtas(TempX,Next),
    \+isBawah(TempX,Next),
    \+isKanan(TempX,Next),
    \+isKiri(TempX,Next),
    \+isGym(TempX,Next),
    retract(positionY(A)),
    asserta(positionY(Next)),!.

s :- 
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    (
        isAtas(TempX,Next);
        isBawah(TempX,Next);
        isKanan(TempX,Next);
        isKiri(TempX,Next)
    ),
    write('Ada Tembok'),!.

s :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    isGym(TempX,Next),
    asserta(cure(1)),
    write('Anda masuk gym'),
    retract(positionY(A)),
    asserta(positionY(Next)),!.

n :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    \+isAtas(TempX,Next),
    \+isBawah(TempX,Next),
    \+isKanan(TempX,Next),
    \+isKiri(TempX,Next),
    \+isGym(TempX,Next),
    retract(positionY(A)),
    asserta(positionY(Next)),!.

n :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    (
        isAtas(TempX,Next);
        isBawah(TempX,Next);
        isKanan(TempX,Next);
        isKiri(TempX,Next)
    ),
    write('Ada Tembok'),!.

n :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    isGym(TempX,Next),
    asserta(cure(1)),
    write('Anda masuk gym'),
    retract(positionY(A)),
    asserta(positionY(Next)),!.

e :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    \+isAtas(Next,Temp),
    \+isBawah(Next,Temp),
    \+isKanan(Next,Temp),
    \+isKiri(Next,Temp),
    \+isGym(TempX,Next),
    retract(positionX(A)),
    asserta(positionX(Next)),!.

e :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    (
        isAtas(Next,Temp);
        isBawah(Next,Temp);
        isKanan(Next,Temp);
        isKiri(Next,Temp)
    ),
    write('Ada Tembok'),!.

e :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    isGym(Next,Temp),
    asserta(cure(1)),
    write('Anda masuk gym'),
    retract(positionX(A)),
    asserta(positionX(Next)),!.

w :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    \+isAtas(Next,Temp),
    \+isBawah(Next,Temp),
    \+isKanan(Next,Temp),
    \+isKiri(Next,Temp),
    \+isGym(TempX,Next),
    retract(positionX(A)),
    asserta(positionX(Next)),!.

w :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    (
        isAtas(Next,Temp);
        isBawah(Next,Temp);
        isKanan(Next,Temp);
        isKiri(Next,Temp)
    ),
    write('Ada Tembok'),!.

e :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    isGym(Next,Temp),
    asserta(cure(1)),
    write('Anda masuk gym'),
    retract(positionX(A)),
    asserta(positionX(Next)),!.