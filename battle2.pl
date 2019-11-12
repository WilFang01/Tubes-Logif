:- dynamic(enemyTokemon/9).     /* enemyTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special) */
:- dynamic(myTokemon/10).       /* myTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special, Exp) */
:- dynamic(peluang/1).
:- dynamic(isRun/1).
:- dynamic(isSkill/1).
:- dynamic(isEnemySkill/1).
:- dynamic(isEnemyAlive/1).
:- dynamic(battle/1).
:- include('player.pl').
:- include('tokedex.pl').

superEffective(fire, grass).
superEffective(grass, water).
superEffective(water, fire).
lessEffective(grass, fire).
lessEffective(water, grass).
lessEffective(fire, water).

/* ---------- INTRO BATTLE ---------- */
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
    random(1, 10, P),
    asserta(peluang(P)),
    asserta(battle(1)),
    asserta(isEnemyAlive(1)).

/* ---------- RUN ---------- */

/* ----- RUN GAGAL ----- */
run :-
    \+ isRun(_),
    battle(_),
    peluang(P), 
    P < 5,
    write('Kamu gagal lari, jadi kamu harus kalahkan tokemon liar itu!'), nl,
    retract(peluang(P)),
    fight,
    !.
/* --------------------- */

/* ----- RUN BERHASIL ----- */
run :-
    \+ isRun(_),
    battle(_),
    peluang(P),
    P >= 5,
    write('Kamu berhasil lari! Fyuh~'),
    retract(peluang(P)),
    retract(battle(_)),
    retract(enemyTokemon(_, _, _, _, _, _, _, _, _)),
    !.
/* ------------------------ */

/* ----- RUN SUDAH GAGAL ----- */
run :-
    isRun(_),
    write('E-e-eh! Kamu sudah gagal run lo ya... Ayo, semangat~!'), nl,
    cont.

/* ---------- FIGHT -------- */
fight :-
    asserta(isRun(_)),
    battle(_),
    asserta(isEnemySkill(1)),
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    read(Name),nl,
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    asserta(myTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp)),
    write('Kamu memilih '), write(Name), write(' dengan health '), write(Health), nl,
    asserta(isSkill(1)),
    cont.

fightChance :-
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    read(Name),nl,
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    asserta(myTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp)),
    write('Kamu memilih '), write(Name), write(' dengan health '), write(Health), nl,
    asserta(isSkill(1)),
    cont.

/* ---------- CONTINUE/END TURN ---------- */
cont :-
    write('Sekarang ngapain nih?'), nl,
    write('- attack'), nl,
    write('- skill'), nl,
    !.

/* ---------- ATTACK ---------- */

/* ----- COMMENT ----- */
attackComment :-
    enemyTokemon(_, EnemyName, _, _, _, EnemyHealth, _, _, _),
    EnemyHealth > 0,
    write('Health '), write(EnemyName), write(' tersisa '), write(EnemyHealth), nl,
    write('Sekarang giliran musuh!'), nl,
    write('...'), nl,
    sleep(1),
    enemyAttack,
    !.

attackComment :-
    enemyTokemon(_, EnemyName, _, _, _, EnemyHealth, _, _, _),
    EnemyHealth =< 0,
    write(EnemyName), write(' pingsan!'), nl,
    retract(myTokemon(ID, _, _, _, _, MyHealth, _, _, _, _)),
    retract(inventory(ID, Name, Type, MaxHealth, Level, _, Element, Attack, Special, Exp)),
    asserta(inventory(ID, Name, Type, MaxHealth, Level, MyHealth, Element, Attack, Special, Exp)),
    write('Apakah kamu mau menangkap '), write(EnemyName), write('?'), nl,
    write('- capture'), nl,
    write('- skip'), nl,
    retract(battle(1)),
    !.

/* ----- ATTACK ----- */
attack :-
    battle(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, MyAttack, _, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    NewEnemyHealth is (EnemyHealth-MyAttack),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(MyName), write(' menggunakan attack!'), nl,
    attackComment,!.
/* ------------------- */

/* ---------- ENEMY ATTACK ----------- */

/* ----- ENEMY ATTACK COMMENT ----- */
enemyAttackComment :-
    myTokemon(MyID, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth =< 0,
    retract(myTokemon(_, _, _, _, _, _, _, _, _, _)),
    delTokemon(MyID),
    cekPanjang(X),
    X =:= 0,
    write(MyName), write(' pingsan!'), nl,
    write('Kamu sudah tidak memiliki tokemon lagi di inventori!'), nl,
    !.

enemyAttackComment :-
    myTokemon(_, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth =< 0,
    retract(myTokemon(_, _, _, _, _, _, _, _, _, _)),
    cekPanjang(X),
    X \== 0,
    write(MyName), write(' pingsan!'), nl,
    write('Pilih Tokemon yang lain di inventorimu'), nl,
    fightChance,
    !.

enemyAttackComment :-
    myTokemon(_, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth > 0,
    write('Health '), write(MyName), write(' tersisa '), write(MyHealth),
    !.

/* ----- ENEMY ATTACK ----- */
enemyAttack :-
    enemyTokemon(_, EnemyName, _, _, _, _, EnemyElement, EnemyAttack, _),
    myTokemon(_, _, _, _, _, MyHealth, MyElement, _, _, _),
    NewMyHealth is (MyHealth-EnemyAttack),
    retract(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, MyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    asserta(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, NewMyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    write(EnemyName), write(' menggunakan attack!'), nl,
    enemyAttackComment,
    !.

/* ---------- SKILL ATTACK ---------- */
/* ----- SUPER EFFECTIVE ----- */
skill :-
    battle(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, _, MySpecial, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    superEffective(MyElement, EnemyElement),
    NewSpecial is (MySpecial*1.5),
    NewEnemyHealth is (EnemyHealth-NewSpecial),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(MyName), write(' menggunakan Skill!'), nl,
    attackComment,!.

/* ----- LESS EFFECTIVE ----- */
skill :-
    battle(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, _, MySpecial, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    lessEffective(MyElement, EnemyElement),
    NewSpecial is (MySpecial*0.5),
    NewEnemyHealth is (EnemyHealth-NewSpecial),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(MyName), write(' menggunakan Skill!'), nl,
    attackComment,!.

/* ----- ELEMEN SAMA ----- */
skill :-
    battle(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, _, MySpecial, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    \+ superEffective(EnemyElement, MyElement),
    \+ lessEffective(EnemyElement, MyElement),
    NewEnemyHealth is (EnemyHealth-MySpecial),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(MyName), write(' menggunakan Skill!'), nl,
    attackComment,!.

/* ---------- ENEMY SKILL ---------- */
/* ----- SUPER EFFECTIVE ----- */
enemySkill :-
    enemyTokemon(_, EnemyName, _, _, _, _, EnemyElement, _, EnemySkill),
    myTokemon(_, _, _, _, _, MyHealth, MyElement, _, _, _),
    superEffective(EnemyElement, MyElement),
    NewSkill is (EnemySkill*1.5),
    NewMyHealth is (MyHealth-NewSkill),
    retract(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, MyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    asserta(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, NewMyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    write(EnemyName), write(' menggunakan skill!'), nl,
    enemyAttackComment,
    !.

/* ----- LESS EFFECTIVE ----- */
enemySkill :-
    enemyTokemon(_, EnemyName, _, _, _, _, EnemyElement, _, EnemySkill),
    myTokemon(_, _, _, _, _, MyHealth, MyElement, _, _, _),
    lessEffective(EnemyElement, MyElement),
    NewSkill is (EnemySkill*0.5),
    NewMyHealth is (MyHealth-NewSkill),
    retract(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, MyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    asserta(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, NewMyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    write(EnemyName), write(' menggunakan skill!'), nl,
    enemyAttackComment,
    !.

/* ----- ELEMEN SAMA ----- */
enemySkill :-
    enemyTokemon(_, EnemyName, _, _, _, _, EnemyElement, _, EnemySkill),
    myTokemon(_, _, _, _, _, MyHealth, MyElement, _, _, _),
    \+superEffective(EnemyElement, MyElement),
    \+lessEffective(EnemyElement, MyElement),
    NewMyHealth is (MyHealth-EnemySkill),
    retract(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, MyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    asserta(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, NewMyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    write(EnemyName), write(' menggunakan skill!'), nl,
    enemyAttackComment,
    !.

/* ---------- CAPTURE ---------- */
capture :-
    \+ isFull,
    retract(enemyTokemon(EnemyID, EnemyName, _, _, _, _, _, _, _)),
    addTokemon(EnemyID),
    write(EnemyName), write(' berhasil dimasukkan ke inventorimu!'), nl,
    retract(battle(_)),
    !.

capture :-
    retract(enemyTokemon(EnemyID, EnemyName, _, _, _, _, _, _, _)),
    write('Inventorimu penuh! Pilih satu tokemonmu untuk ditukar dengan '), write(EnemyName), nl,
    statusInventory,
    read(Name),
    tokedex(ID, Name, _, _, _, _, _, _),
    delTokemon(ID),
    addTokemon(EnemyID),
    write(Name), write(' berhasil ditukar dengan '), write(EnemyName), nl,
    write(Name), write(' dibebaskan ke habitatnya kembali.'), nl, 
    retract(battle(_)),
    !.

skip :-
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(EnemyName), write(' terbangun dan segera berlari ke semak-semak, menghilang dari pandanganmu.'), nl,
    write('Kamu pun melanjutkan perjalananmu.'), 
    retract(battle(_)),
    !.