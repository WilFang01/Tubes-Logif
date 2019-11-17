levelUp(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,_,Element,Attack,Special,Exp),
    TempLevel is (Level+1),
    TempMaxHealth is (MaxHealth + 100),
    TempHealth is TempMaxHealth,
    TempAttack is (Attack + 15),
    TempSpecial is (Special + 15),
    retract(inventory(ID,_,_,_,Level,_,_,_,_,_)),
    asserta(inventory(ID,Name,Type,TempMaxHealth,TempLevel,TempHealth,Element,TempAttack,TempSpecial,Exp)),
    evolve(ID).
    
levelUpEnemy(ID) :-
    enemyTokemon(ID,Name,Type,MaxHealth,Level,_,Element,Attack,Special),
    TempLevel is (Level+1),
    TempMaxHealth is (MaxHealth*1.1),
    TempHealth is TempMaxHealth,
    TempAttack is (Attack*1.1),
    TempSpecial is (Special*1.1),
    retract(enemyTokemon(ID,_,_,_,Level,_,_,_,_)),
    asserta(enemyTokemon(ID,Name,Type,TempMaxHealth,TempLevel,TempHealth,Element,TempAttack,TempSpecial)).

markLevelUp(ID,Level,Exp) :-
    Level =< 1,
    Exp >= 100,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 2,
    Exp >= 300,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 3,
    Exp >= 500,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 4,
    Exp >= 700,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 5,
    Exp >= 1000,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 6,
    Exp >= 1300,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 7,
    Exp >= 1600,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 8,
    Exp >= 1900,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 9,
    Exp >= 2200,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 10,
    Exp >= 2500,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(ID,Level,Exp) :-
    Level =< 11,
    Exp >= 2800,
    write('Leveled Up!!!'),nl,
    levelUp(ID),!.

markLevelUp(_,_,Exp) :-
    Exp < 2801.