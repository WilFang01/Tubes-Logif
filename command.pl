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
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
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
        isKiri(TempX,Next);
        isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next)
    ),
    write('Ada Tembok'),!.

s :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    isGym(TempX,Next),
    write('Anda sekarang berada di gym'),
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
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
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
        isKiri(TempX,Next);
        isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next)
    ),
    write('Ada Tembok'),!.

n :-
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    isGym(TempX,Next),
    write('Anda sekarang berada di gym'),
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
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
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
        isKiri(Next,Temp);
        isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next)
    ),
    write('Ada Tembok'),!.

e :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    isGym(Next,Temp),
    write('Anda sekarang berada di gym'),
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
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
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
        isKiri(Next,Temp);
        isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next)
    ),
    write('Ada Tembok'),!.

e :-
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    isGym(Next,Temp),
    write('Anda sekarang berada di gym'),
    retract(positionX(A)),
    asserta(positionX(Next)),!.

help :-
    init(_),
    write('Commands: '), nl,
    write('    start. -- start the game!'), nl,
    write('    help. -- show available commands'), nl,
    write('    n. s. e. w. -- move'), nl,
    write('    heal. -- cure all tokemon in inventory when in gym center'), nl,
    write('    status. -- show your status'), nl,
    write('    save(Filename). -- save your game'), nl,
    write('    load(Filename). -- load your game'), nl.

listHealAll(ListNama) :-
    findall(Name, inventory(_,Name,_,_,_,_,_,_,_,_), ListNama).

healAll([]).
healAll([B|Y]) :-
    retract(inventory(ID, B, Type, MaxHealth, Level, Health, Element, Attack, Special, Exp)),
    NewHealth is MaxHealth,
    asserta(inventory(ID, B, Type, MaxHealth, Level, NewHealth, Element, Attack, Special, Exp)),
    healAll(Y).


heal :-
    positionX(X),
    positionY(Y),
    isGym(X,Y),
    listHealAll(ListNama),
    healAll(ListNama),
    write('Semua tokemon anda telah sembuh'),
    retract(cure(_)),!.