/***** EVOLUTION *****/

/*** Evolution for Starter Tokemon ***/
/* First Evolution */
evolve(ID) :-
    ID >= 1, ID =< 6,
    inventory(ID,Name,Type,_,Level,_,Element,_,_,Exp),
    Level >= 3,
    TempID is (ID + 30),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    write('What???'), nl,
    sleep(1),
    write(Name), write(' berevolusi!'), nl,
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('Selamat! '), write(Name), write(' berevolusi menjadi '), write(TempName), write('!'), nl, nl,
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Second Evolution */
evolve(ID) :-
    ID >= 31, ID =< 36,
    inventory(ID,Name,Type,_,Level,_,Element,_,_,Exp),
    Level >= 6,
    TempID is (ID + 24),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    write('What???'), nl,
    sleep(1),
    write(Name), write(' berevolusi!'), nl,
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('Selamat! '), write(Name), write(' berevolusi menjadi '), write(TempName), write('!'),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Else case */
evolve(ID) :-
    inventory(ID,_,_,_,Level,_,_,_,_,_),
    ID >= 1, ID =< 6, Level < 3, !.

evolve(ID) :-
    inventory(ID,_,_,_,Level,_,_,_,_,_),
    ID >= 31, ID =< 36, Level < 6, !.

evolve(ID) :-
    inventory(ID,_,_,_,_,_,_,_,_,_),
    ID >= 55, ID =< 60, !.


/*** Evolution for Category 1 Tokemon ***/
/* First Evolution */
evolve(ID) :-
    ID >= 7, ID =< 12,
    inventory(ID,Name,Type,_,Level,_,Element,_,_,Exp),
    Level >= 3,
    TempID is (ID + 30),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    write('What???'), nl,
    sleep(1),
    write(Name), write(' berevolusi!'), nl,
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('Selamat! '), write(Name), write(' berevolusi menjadi '), write(TempName), write('!'),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Else case */
evolve(ID) :-
    inventory(ID,_,_,_,Level,_,_,_,_,_),
    ID >= 7, ID =< 12, Level < 3, !.

evolve(ID) :-
    inventory(ID,_,_,_,_,_,_,_,_,_),
    ID >= 37, ID =< 42, !.    

/*** Evolution for Category 2 Tokemon ***/

/* First Evolution */
evolve(ID) :-
    ID >= 13, ID =< 18,
    inventory(ID,Name,Type,_,Level,_,Element,_,_,Exp),
    Level >= 5,
    TempID is (ID + 30),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    write('What???'), nl,
    sleep(1),
    write(Name), write(' berevolusi!'), nl,
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('Selamat! '), write(Name), write(' berevolusi menjadi '), write(TempName), write('!'),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Else case */
evolve(ID) :-
    inventory(ID,_,_,_,Level,_,_,_,_,_),
    ID >= 13, ID =< 18, Level < 5, !.

evolve(ID) :-
    inventory(ID,_,_,_,_,_,_,_,_,_),
    ID >= 43, ID =< 48, !.

/*** Evolution for Category 4 Tokemon ***/

/* First Evolution */
evolve(ID) :-
    ID >= 25, ID =< 30,
    inventory(ID,Name,Type,_,Level,_,Element,_,_,Exp),
    Level >= 4,
    TempID is (ID + 24),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    write('What???'), nl,
    sleep(1),
    write(Name), write(' berevolusi!'), nl,
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('Selamat! '), write(Name), write(' berevolusi menjadi '), write(TempName), write('!'),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Second Evolution */
evolve(ID) :-
    ID >= 49, ID =< 54,
    inventory(ID,Name,Type,_,Level,_,Element,_,_,Exp),
    Level >= 8,
    TempID is (ID + 12),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    write('What???'), nl,
    sleep(1),
    write(Name), write(' berevolusi!'), nl,
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('.'), nl,
    sleep(1),
    write('Selamat! '), write(Name), write(' berevolusi menjadi '), write(TempName), write('!'),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Else case */
evolve(ID) :-
    inventory(ID,_,_,_,Level,_,_,_,_,_),
    ID >= 25, ID =< 30, Level < 4, !.

evolve(ID) :-
    inventory(ID,_,_,_,Level,_,_,_,_,_),
    ID >= 49, ID =< 54, Level < 8, !.

evolve(ID) :-
    inventory(ID,_,_,_,_,_,_,_,_,_),
    ID >= 61, ID =< 66, !.

/*** General Else Case ***/
evolve(ID) :-
    ID < 1, !.

evolve(ID) :-
    ID > 66, !.
    
evolve(ID) :-
    ID >= 19, ID =< 24, !.