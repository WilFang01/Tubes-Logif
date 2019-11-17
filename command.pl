:- dynamic(cure/1).

s :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    \+isAtas(TempX,Next),
    \+isBawah(TempX,Next),
    \+isKanan(TempX,Next),
    \+isKiri(TempX,Next),
    \+isGym(TempX,Next),
    \+isLegendary1(TempX,Next),
    \+isLegendary2(TempX,Next),
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
    triggered,
    retract(positionY(_)),
    asserta(positionY(Next)),!.

s :- 
    init(_),
    \+ isEnemyAlive(_),
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
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    isGym(TempX,Next),
    write('Anda sekarang berada di gym'),
    retract(positionY(_)),
    asserta(positionY(Next)),!.

s :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    isLegendary1(TempX,Next),
    legendaryTriggered1,
    retract(positionY(_)),
    asserta(positionY(Next)),!.

s :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp+1),
    isLegendary2(TempX,Next),
    legendaryTriggered2,
    retract(positionY(_)),
    asserta(positionY(Next)),!.

s :-
    \+init(_),
    write('Game belum dimulai').

n :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    \+isAtas(TempX,Next),
    \+isBawah(TempX,Next),
    \+isKanan(TempX,Next),
    \+isKiri(TempX,Next),
    \+isGym(TempX,Next),
    \+isTembok(TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next,TempX,Next),
    \+isLegendary1(TempX,Next),
    \+isLegendary2(TempX,Next),
    triggered,
    retract(positionY(_)),
    asserta(positionY(Next)),!.

n :-
    init(_),
    \+ isEnemyAlive(_),
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
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    isGym(TempX,Next),
    write('Anda sekarang berada di gym'),
    retract(positionY(_)),
    asserta(positionY(Next)),!.

n :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    isLegendary1(TempX,Next),
    legendaryTriggered1,
    retract(positionY(_)),
    asserta(positionY(Next)),!.

n :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (Temp-1),
    isLegendary2(TempX,Next),
    legendaryTriggered2,
    retract(positionY(_)),
    asserta(positionY(Next)),!.

n :-
    \+init(_),
    write('Game belum dimulai').

e :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    \+isAtas(Next,Temp),
    \+isBawah(Next,Temp),
    \+isKanan(Next,Temp),
    \+isKiri(Next,Temp),
    \+isGym(Next,Temp),
    \+isLegendary1(Next,Temp),
    \+isLegendary2(Next,Temp),
    \+isTembok(Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp),
    triggered,
    retract(positionX(_)),
    asserta(positionX(Next)),!.

e :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    (
        isAtas(Next,Temp);
        isBawah(Next,Temp);
        isKanan(Next,Temp);
        isKiri(Next,Temp);
        isTembok(Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp)
    ),
    write('Ada Tembok'),!.

e :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    isGym(Next,Temp),
    write('Anda sekarang berada di gym'),
    retract(positionX(_)),
    asserta(positionX(Next)),!.

e :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    isLegendary1(Next,Temp),
    legendaryTriggered1,
    retract(positionX(_)),
    asserta(positionX(Next)),!.

e :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX+1),
    isLegendary2(Next,Temp),
    legendaryTriggered2,
    retract(positionX(_)),
    asserta(positionX(Next)),!.

e :-
    \+init(_),
    write('Game belum dimulai').

w :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    \+isAtas(Next,Temp),
    \+isBawah(Next,Temp),
    \+isKanan(Next,Temp),
    \+isKiri(Next,Temp),
    \+isGym(Next,Temp),
    \+isLegendary1(Next,Temp),
    \+isLegendary2(Next,Temp),
    \+isTembok(Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp),
    triggered,
    retract(positionX(_)),
    asserta(positionX(Next)),!.

w :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    (
        isAtas(Next,Temp);
        isBawah(Next,Temp);
        isKanan(Next,Temp);
        isKiri(Next,Temp);
        isTembok(Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp,Next,Temp)
    ),
    write('Ada Tembok'),!.

w :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    isGym(Next,Temp),
    write('Anda sekarang berada di gym'),
    retract(positionX(_)),
    asserta(positionX(Next)),!.

w :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    isLegendary1(Next,Temp),
    legendaryTriggered1,
    retract(positionX(_)),
    asserta(positionX(Next)),!.

w :-
    init(_),
    \+ isEnemyAlive(_),
    positionX(TempX),
    positionY(Temp),
    Next is (TempX-1),
    isLegendary2(Next,Temp),
    legendaryTriggered2,
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

loop(1,_).
loop(X,ID) :-
    X > 0,
    levelUpEnemy(ID),
    M is X-1,
    loop(M,ID).