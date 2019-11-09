:- dynamic(cure/1).

:- include('map.pl').

s :-
    init(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    \+isAtas(TempX,Next),
    \+isBawah(TempX,Next),
    \+isKanan(TempX,Next),
    \+isKiri(TempX,Next),
    \+isGym(TempX,Next),
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
    triggered,
    retract(positionY(_)),
    asserta(positionY(Next)),!.

s :- 
    init(_),
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
    init(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    isGym(TempX,Next),
    write('Anda sekarang berada di gym'),
    retract(positionY(_)),
    asserta(positionY(Next)),!.

s :-
    \+init(_),
    write('Game belum dimulai').

n :-
    init(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    \+isAtas(TempX,Next),
    \+isBawah(TempX,Next),
    \+isKanan(TempX,Next),
    \+isKiri(TempX,Next),
    \+isGym(TempX,Next),
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
    triggered,
    retract(positionY(_)),
    asserta(positionY(Next)),!.

n :-
    init(_),
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
    init(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    isGym(TempX,Next),
    write('Anda sekarang berada di gym'),
    retract(positionY(_)),
    asserta(positionY(Next)),!.

n :-
    \+init(_),
    write('Game belum dimulai').

e :-
    init(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    \+isAtas(Next,Temp),
    \+isBawah(Next,Temp),
    \+isKanan(Next,Temp),
    \+isKiri(Next,Temp),
    \+isGym(TempX,Next),
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
    triggered,
    retract(positionX(_)),
    asserta(positionX(Next)),!.

e :-
    init(_),
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
    init(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    isGym(Next,Temp),
    write('Anda sekarang berada di gym'),
    retract(positionX(_)),
    asserta(positionX(Next)),!.

e :-
    \+init(_),
    write('Game belum dimulai').

w :-
    init(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    \+isAtas(Next,Temp),
    \+isBawah(Next,Temp),
    \+isKanan(Next,Temp),
    \+isKiri(Next,Temp),
    \+isGym(Next,Temp),
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
    triggered,
    retract(positionX(_)),
    asserta(positionX(Next)),!.

w :-
    init(_),
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

w :-
    init(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    isGym(Next,Temp),
    write('Anda sekarang berada di gym'),
    retract(positionX(_)),
    asserta(positionX(Next)),!.

w :- 
    \+init(_),
    write('Game belum dimulai').


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
    retract(inventory(ID, B, Type, MaxHealth, Level,_, Element, Attack, Special, Exp)),
    NewHealth is MaxHealth,
    asserta(inventory(ID, B, Type, MaxHealth, Level, NewHealth, Element, Attack, Special, Exp)),
    healAll(Y).

heal :-
    init(_),
    positionX(X),
    positionY(Y),
    isGym(X,Y),
    listHealAll(ListNama),
    healAll(ListNama),
    write('Semua tokemon anda telah sembuh'),
    retract(cure(_)),!.

triggered :-
    random(1,100,L),
    (
        L >= 80
        -> enemyTriggered
        ; !
    ).