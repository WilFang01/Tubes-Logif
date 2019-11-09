:- include('player.pl').

levelUp(ID) :-
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    TempLevel is (Level+1),
    TempMaxHealth is (MaxHealth*2),
    TempHealth is TempMaxHealth,
    TempAttack is (Attack*1.2),
    TempSpecial is (Special*1.2),
    TempExp is 0,
    retract(inventory(ID,_,_,_,Level,_,_,_,_,_)),
    asserta(inventory(ID,Name,Type,TempMaxHealth,TempLevel,TempHealth,Element,TempAttack,TempSpecial,TempExp)).