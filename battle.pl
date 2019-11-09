:- dynamic(enemyTokemon/9).     /* enemyTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special) */
:- dynamic(myTokemon/10).
:- dynamic(peluang/1).
:- dynamic(isSkill/1).
:- dynamic(isEnemySkill/1).
:- include('player.pl').
:- include('tokedex.pl').

superEffective(fire,grass).
superEffective(grass,water).
superEffective(water,fire).
lessEffective(grass,fire).
lessEffective(water,grass).
lessEffective(fire,water).

enemyTriggered :-
    random(1,3,ID),
    tokedex(ID,Name,Type,MaxHealth,Level,Element,Attack,Special),
    Health is MaxHealth,
    asserta(enemyTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special)),
    write('Kamu ketemu '), write(Name), write(' liar dengan level '), write(Level), write('!'), nl,
    write('Apa yang akan kamu lakukan?'), nl,
    write('- fight'), nl,
    write('- run'), nl,
    write('Ketik pilihan diakhiri titik, contoh: fight.'), nl,
    random(1,10,P),
    asserta(peluang(P)),
    asserta(isEnemySkill(1)).

run :-
    peluang(P), 
    P < 5,
    write('Kamu gagal lari, jadi kamu harus kalahkan tokemon liar itu!'),
    retract(peluang(P)),
    fight,
    !.

run :-
    peluang(P),
    P >= 5,
    write('Kamu berhasil lari! Fyuh~'),
    retract(peluang(P)),
    !.

fight :-
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    read(Name),nl,
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    asserta(myTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp)),
    write('Kamu memilih '), write(Name), write(' dengan health '), write(Health),
    asserta(isSkill(1)),
    cont.

cont :-
    write('Sekarang ngapain nih?'), nl,
    write('- attack'), nl,
    write('- skill'), nl, !.

attack :-
    myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    lessEffective(MyElement,MyElement),
    NewAttack is (MyAttack*0.5),
    (EnemyHealth-NewAttack) =< 0,
    write('Kamu memilih attack! Tetapi tidak terlalu effective!'), nl,
    delTokemon(MyID),
    asserta(inventory(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,MyExp)),
    write(name), write(' pingsan!'), nl,
    write('Apakah kamu mau menangkap tokemon '), write(name), nl,
    write('- Capture'), nl,
    write('- Skip'), nl, !.

attack :-
    myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    superEffective(MyElement,MyElement),
    NewAttack is (MyAttack*1.5),
    (EnemyHealth-NewAttack) =< 0,
    write('Kamu memilih attack! Dan super effective!'), nl,
    delTokemon(MyID),
    asserta(inventory(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,MyExp)),
    write(name), write(' pingsan!'), nl,
    write('Apakah kamu mau menangkap tokemon '), write(name), nl,
    write('- Capture'), nl,
    write('- Skip'), nl, !.

attack :-
    myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    EnemyHealth-MyAttack =< 0,
    write('Kamu memilih attack!'), nl,
    delTokemon(MyID),
    asserta(inventory(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,MyExp)),
    write(Name), write(' pingsan!'), nl,
    write('Apakah kamu mau menangkap tokemon '), write(name), nl,
    write('- Capture'), nl,
    write('- Skip'), nl,!.

attack :-
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,Exp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    superEffective(MyElement,MyElement),
    NewAttack is (MyAttack*1.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Kamu memilih attack! Dan super effective!'), nl,
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write('Sekarang giliran musuh!'), nl,
    enemyAttack,!.

attack :-
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    lessEffective(MyElement,MyElement),
    NewAttack is (MyAttack*0.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Kamu memilih attack! Tetapi tidak terlalu effective!'), nl,
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write('Sekarang giliran musuh!'), nl,
    enemyAttack,!.


attack :-
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    NewEnemyHealth is (EnemyHealth-MyAttack),
    write('Kamu memilih attack!'), nl,
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write('Sekarang giliran musuh!'), nl,
    enemyAttack,!.

skill :-
    \+isSkill(_),
    write('Kamu sudah memakai skill'), nl,
    cont,!.

skill :-
    isSkill(_),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,Exp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    superEffective(MyElement,MyElement),
    NewAttack is (MySpecial*1.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Kamu memilih skill! Dan super effective!'), nl,
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    retract(isSkill(_)),
    write('Sekarang giliran musuh!'), nl,
    enemyAttack,!.

skill :-
    isSkill(_),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,Exp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    lessEffective(MyElement,MyElement),
    NewAttack is (MySpecial*1.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Kamu memilih skill! Tapi tidak terlalu effective!'), nl,
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    retract(isSkill(_)),
    write('Sekarang giliran musuh!'), nl,
    enemyAttack,!.

skill :-
    isSkill(_),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,Exp),
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,_,_),
    NewEnemyHealth is (EnemyHealth-MySpecial),
    write('Kamu memilih skill!'), nl,
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    retract(isSkill(_)),
    write('Sekarang giliran musuh!'), nl,
    enemyAttack,!.

enemyAttack :-
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,MyName,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    superEffective(EnemyElement,MyElement),
    NewAttack is (EnemyAttack*1.5),
    MyHealth-NewAttack =< 0,
    write('Enemy memilih attack! Dan super effective!'), nl,
    write('Oh, tidak! '), write(MyName), write('pingsan!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    statusInventory, !.

enemyAttack :-
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    lessEffective(EnemyElement,MyElement),
    NewAttack is (EnemyAttack*0.5),
    MyHealth-NewAttack =< 0,
    write('Enemy memilih attack! Tapi tidak terlalu effective!'), nl,
    write('Oh, tidak! '), write(MyName), write('pingsan!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    statusInventory, !.

enemyAttack :-
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
    MyHealth-EnemyAttack =< 0,
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
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
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
    enemyTokemon(_,Name,_,EnemyMaxHealth,_,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial),
    myTokemon(_,_,_,MyMaxHealth,_,MyHealth,MyElement,MyAttack,MySpecial,MyExp),
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
    write(EnemyName), write(' berhasil dimasukkan ke inventorimu!'), nl, !.

capture :-
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write('Inventorimu penuh! Pilih satu tokemonmu untuk ditukar dengan '), write(EnemyName), nl,
    statusInventory,
    read(Name),
    tokedex(ID, Name, _, _, _, _, _, _),
    delTokemon(ID),
    addTokemon(EnemyID),
    write(Name), write(' berhasil ditukar dengan '), write(EnemyName), nl,
    write(Name), write(' dibebaskan ke habitatnya kembali.'), nl, !.

skip :-
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(EnemyName), write(' terbangun dan segera berlari ke semak-semak, menghilang dari pandanganmu.'), nl,
    write('Kamu pun melanjutkan perjalananmu.'), !.