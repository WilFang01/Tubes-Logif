/***** EVOLUTION *****/

/*** Evolution for Starter Tokemon ***/
/* First Evolution */
evolve(ID) :-
    ID >= 1, ID =< 6,
    inventory(ID,Name,Type,MaxHealth,Level,_,Element,Attack,Special,Exp),
    Level >= 3,
    TempID is (ID + 30),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Second Evolution */
evolve(ID) :-
    ID >= 31, ID =< 36,
    inventory(ID,Name,Type,MaxHealth,Level,_,Element,Attack,Special,Exp),
    Level >= 6,
    TempID is (ID + 24),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Else case */
evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 1, ID =< 6, Level < 3, !.

evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 31, ID =< 36, Level < 6, !.

evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 55, ID =< 60, !.


/*** Evolution for Category 1 Tokemon ***/
/* First Evolution */
evolve(ID) :-
    ID >= 7, ID =< 12,
    inventory(ID,Name,Type,MaxHealth,Level,_,Element,Attack,Special,Exp),
    Level >= 3,
    TempID is (ID + 30),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Else case */
evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 7, ID =< 12, Level < 3, !.

evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 37, ID =< 42, !.    

/*** Evolution for Category 2 Tokemon ***/

/* First Evolution */
evolve(ID) :-
    ID >= 13, ID =< 18,
    inventory(ID,Name,Type,MaxHealth,Level,_,Element,Attack,Special,Exp),
    Level >= 5,
    TempID is (ID + 30),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Else case */
evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 13, ID =< 18, Level < 5, !.

evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 43, ID =< 48, !.

/*** Evolution for Category 4 Tokemon ***/

/* First Evolution */
evolve(ID) :-
    ID >= 25, ID =< 30,
    inventory(ID,Name,Type,MaxHealth,Level,_,Element,Attack,Special,Exp),
    Level >= 4,
    TempID is (ID + 24),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Second Evolution */
evolve(ID) :-
    ID >= 49, ID =< 54,
    inventory(ID,Name,Type,MaxHealth,Level,_,Element,Attack,Special,Exp),
    Level >= 8,
    TempID is (ID + 12),
    tokedex(TempID,TempName,_,EvoMaxHealth,_,_,EvoAttack,EvoSpecial),
    retract(inventory(ID,Name,_,_,_,_,_,_,_,_)),
    asserta(inventory(TempID,TempName,Type,EvoMaxHealth,Level,EvoMaxHealth,Element,EvoAttack,EvoSpecial,Exp)),
    !.

/* Else case */
evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 25, ID =< 30, Level < 4, !.

evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 49, ID =< 54, Level < 8, !.

evolve(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    ID >= 61, ID =< 66, !.

/*** General Else Case ***/
evolve(ID) :-
    ID < 1, !.

evolve(ID) :-
    ID > 66, !.
    
evolve(ID) :-
    ID >= 19, ID =< 24, !.