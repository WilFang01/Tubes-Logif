:- dynamic(enemyTokemon/9).     /* enemyTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special) */
:- dynamic(myTokemon/10).
:- dynamic(peluang/1).
:- dynamic(isSkill/1).
:- dynamic(isEnemySkill/1).
:- dynamic(battle/1).
:- include('player.pl').
:- include('tokedex.pl').

superEffective(fire, grass).
superEffective(grass, water).
superEffective(water, fire).
lessEffective(grass, fire).
lessEffective(water, grass).
lessEffective(fire, water).

enemyTriggered :-
    random(1, 3, ID),
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,
    asserta(enemyTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special)),
    write('Kamu ketemu '), write(Name), write(' liar dengan level '), write(Level), write('!'), nl,
    write('Apa yang akan kamu lakukan?'), nl,
    write('- fight'), nl,
    write('- run'), nl,
    write('Ketik pilihan diakhiri titik, contoh: fight.'), nl,
    random(1,10,P),
    asserta(peluang(P)),
    asserta(battle(1)),
    asserta(isEnemySkill(1)).

run :-
    battle(_),
    peluang(P), 
    P < 5,
    write('Kamu gagal lari, jadi kamu harus kalahkan tokemon liar itu!'),
    retract(peluang(P)),
    fight,
    retrct(battle(_)),
    !.

run :-
    battle(_),
    peluang(P),
    P >= 5,
    write('Kamu berhasil lari! Fyuh~'),
    retract(peluang(P)),
    retract(battle(_)),
    !.

fight :-
    battle(_),
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    read(Name),nl,
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    asserta(myTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp)),
    write('Kamu memilih '), write(Name), write(' dengan health '), write(Health), nl,
    asserta(isSkill(1)),
    cont.

cont :-
    write('Sekarang ngapain nih?'), nl,
    write('- attack'), nl,
    write('- skill'), nl, !.

enemyPingsan :-
    myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    write('Kamu memilih attack! Tetapi tidak terlalu effective!'), nl,
    delTokemon(MyID),
    asserta(inventory(MyID, MyName, MyType, MyMaxHealth, MyLevel, MyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    write(MyName), write(' pingsan!'), nl,
    write('Apakah kamu mau menangkap tokemon '), write(MyName), nl,
    write('- capture'), nl,
    write('- skip'), nl,
    !.

healthEnemy(NewEnemyHealth) :-
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    write('Sekarang giliran musuh!'), nl,
    enemyAttack,!.

attack :-
    myTokemon(_, _, _, _, _, _, MyAttack, MyElement, _, _),
    enemyTokemon(_, Name, _, _, _, EnemyHealth, EnemyElement, _, _),
    lessEffective(MyElement, EnemyElement),
    NewAttack is (MyAttack*0.5),
    ((EnemyHealth-NewAttack) =< 0),
    enemyPingsan.

attack :-
    myTokemon(_, _, _, _, _, _, MyAttack, MyElement, _, _),
    enemyTokemon(_, Name, _, _, _, EnemyHealth, EnemyElement, _, _),
    superEffective(MyElement, EnemyElement),
    NewAttack is (MyAttack*1.5),
    ((EnemyHealth-NewAttack) =< 0),
    write('Kamu memilih attack! Dan super effective!'), nl,
    enemyPingsan.

attack :-
    myTokemon(_, _, _, _, _, _, MyAttack, MyElement, _, _),
    enemyTokemon(_, Name, _, _, _, EnemyHealth, EnemyElement, _, _),
    \+ lessEffective(MyElement, EnemyElement),
    \+ superEffective(MyElement, EnemyElement),
    ((EnemyHealth-MyAttack) =< 0),
    write('Kamu memilih attack!'), nl,
    enemyPingsan.

attack :-
    myTokemon(_,_,_,_,_,MyHealth,MyElement,MyAttack,_,_),
    enemyTokemon(_,_,_,_,_,EnemyHealth,EnemyElement,_,_),
    superEffective(MyElement,EnemyElement),
    NewAttack is (MyAttack*1.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Kamu memilih attack! Dan super effective!'), nl,
    healthEnemy(NewEnemyHealth).

attack :-
    myTokemon(_,_,_,_,_,MyHealth,MyElement,MyAttack,_,_),
    enemyTokemon(_,_,_,_,_,EnemyHealth,EnemyElement,_,_),
    lessEffective(MyElement,EnemyElement),
    NewAttack is (MyAttack*0.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    healthEnemy(NewEnemyHealth).


attack :-
    myTokemon(_,_,_,_,_,MyHealth,MyElement,MyAttack,_,_),
    enemyTokemon(_,_,_,_,_,EnemyHealth,EnemyElement,_,_),
    \+ lessEffective(MyElement, EnemyElement),
    \+ superEffective(MyElement, EnemyElement),
    NewEnemyHealth is (EnemyHealth-MyAttack),
    write('Kamu memilih attack!'), nl,
    healthEnemy(NewEnemyHealth).

skill :-
    \+isSkill(_),
    write('Kamu sudah memakai skill'), nl,
    cont,!.

skill :-
    isSkill(_),
    myTokemon(_,_,_,_,_,_,MyElement,_,MySpecial,_),
    enemyTokemon(_,_,_,_,_,EnemyHealth,EnemyElement,_,_),
    superEffective(MyElement,EnemyElement),
    NewAttack is (MySpecial*1.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Kamu memilih skill! Dan super effective!'), nl,
    healthEnemy(NewEnemyHealth).

skill :-
    isSkill(_),
    myTokemon(_,_,_,_,_,_,MyElement,_,MySpecial,_),
    enemyTokemon(_,_,_,_,_,EnemyHealth,EnemyElement,_,_),
    lessEffective(MyElement,EnemyElement),
    NewAttack is (MySpecial*1.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Kamu memilih skill! Tapi tidak terlalu effective!'), nl,
    healthEnemy(NewEnemyHealth).

skill :-
    isSkill(_),
    myTokemon(_,_,_,_,_,_,MyElement,_,MySpecial,_),
    enemyTokemon(_,_,_,_,_,EnemyHealth,EnemyElement,_,_),
    \+ lessEffective(MyElement, EnemyElement),
    \+ superEffective(MyElement, EnemyElement),
    NewEnemyHealth is (EnemyHealth-MySpecial),
    write('Kamu memilih skill!'), nl,
    healthEnemy(NewEnemyHealth).

enemyAttack :-
    enemyTokemon(_,Name,_,_,_,_,EnemyElement,EnemyAttack,_),
    myTokemon(_,MyName,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    superEffective(EnemyElement,MyElement),
    NewAttack is (EnemyAttack*1.5),
    (MyHealth-NewAttack) =< 0,
    write(Name), write(' memilih attack! Dan super effective!'), nl,
    write('Oh, tidak! '), write(MyName), write('pingsan!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    statusInventory, !.

enemyAttack :-
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    lessEffective(EnemyElement,MyElement),
    NewAttack is (EnemyAttack*0.5),
    (MyHealth-NewAttack) =< 0,
    write('Enemy memilih attack! Tapi tidak terlalu effective!'), nl,
    write('Oh, tidak! '), write(MyName), write('pingsan!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    statusInventory, !.

enemyAttack :-
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    \+ lessEffective(MyElement, EnemyElement),
    \+ superEffective(MyElement, EnemyElement),
    (MyHealth-EnemyAttack) =< 0,
    write('Enemy memilih attack!'), nl,
    write('Oh, tidak! '), write(MyName), write('pingsan!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    statusInventory, !.

enemyAttack :-
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    superEffective(EnemyElement,MyElement),
    NewAttack is (EnemyAttack*1.5),
    NewMyHealth is (MyHealth-NewAttack),
    write('Enemy memilih attack! Dan super effective!'), nl,
    write('Health kamu tersisa '), write(NewMyHealth), write('!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    asserta(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,NewMyHealth,MyElement,MyAttack,MySpecial,Exp)),
    write('Sekarang giliran kamu!'), nl,
    cont,!.

enemyAttack :-
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,_),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    lessEffective(EnemyElement,MyElement),
    NewAttack is (EnemyAttack*0.5),
    NewMyHealth is (MyHealth-NewAttack),
    write('Enemy memilih attack! Tapi tidak terlalu effective!'), nl,
    write('Health kamu tersisa '), write(NewMyHealth), write('!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    asserta(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,NewMyHealth,MyElement,MyAttack,MySpecial,Exp)),
    write('Sekarang giliran kamu!'), nl,
    cont,!.

enemyAttack :-
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,_),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    \+ lessEffective(MyElement, EnemyElement),
    \+ superEffective(MyElement, EnemyElement),
    NewMyHealth is (MyHealth-EnemyAttack),
    write('Enemy memilih attack!'), nl,
    write('Health kamu tersisa '), write(NewMyHealth), write('!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    asserta(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,NewMyHealth,MyElement,MyAttack,MySpecial,Exp)),
    write('Sekarang giliran kamu!'), nl,
    cont,!.

enemySkill :-
    \+ isEnemySkill(_),
    enemyAttack.

enemySkill :-
    isEnemySkill(_),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    superEffective(EnemyElement,MyElement),
    NewAttack is (EnemySpecial*1.5),
    NewMyHealth is (MyHealth-NewAttack),
    write('Enemy memilih skill! Dan super effective!'), nl,
    write('Health kamu tersisa '), write(NewMyHealth), write('!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    asserta(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,NewMyHealth,MyElement,MyAttack,MySpecial,Exp)),
    retract(isEnemySkill(_)),
    write('Sekarang giliran kamu!'), nl,
    cont,!.

enemySkill :-
    isEnemySkill(_),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    lessEffective(EnemyElement,MyElement),
    NewAttack is (EnemySpecial*1.5),
    NewMyHealth is (MyHealth-NewAttack),
    write('Enemy memilih skill! Dan super effective!'), nl,
    write('Health kamu tersisa '), write(NewMyHealth), write('!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    asserta(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,NewMyHealth,MyElement,MyAttack,MySpecial,Exp)),
    retract(isEnemySkill(_)),
    write('Sekarang giliran kamu!'), nl,
    cont,!.

enemySkill :-
    isEnemySkill(_),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    \+ lessEffective(MyElement, EnemyElement),
    \+ superEffective(MyElement, EnemyElement),
    NewMyHealth is (MyHealth-EnemySpecial),
    write('Enemy memilih skill! Dan super effective!'), nl,
    write('Health kamu tersisa '), write(NewMyHealth), write('!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    asserta(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,NewMyHealth,MyElement,MyAttack,MySpecial,Exp)),
    retract(isEnemySkill(_)),
    write('Sekarang giliran kamu!'), nl,
    cont,!.

capture :-
    \+ isFull,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    addTokemon(EnemyID),
    write(EnemyName), write(' berhasil dimasukkan ke inventorimu!'), nl,
    retract(battle(_)),!.

capture :-
    isFull,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write('Inventorimu penuh! Pilih satu tokemonmu untuk ditukar dengan '), write(EnemyName), nl,
    statusInventory,
    read(Name),
    tokedex(ID, Name, _, _, _, _, _, _),
    delTokemon(ID),
    addTokemon(EnemyID),
    write(Name), write(' berhasil ditukar dengan '), write(EnemyName), nl,
    write(Name), write(' dibebaskan ke habitatnya kembali.'), nl, 
    retract(battle(_)),!.

skip :-
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(EnemyName), write(' terbangun dan segera berlari ke semak-semak, menghilang dari pandanganmu.'), nl,
    write('Kamu pun melanjutkan perjalananmu.'), 
    retract(battle(_)),!.