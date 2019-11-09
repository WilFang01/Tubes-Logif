:- dynamic(enemyTokemon/9).     /* enemyTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special) */
:- dynamic(myTokemon/10).
:- dynamic(peluang/1).
:- include('player.pl').
:- include('tokedex.pl').

superEffective(fire,grass).
superEffective(grass,water).
superEffective(water,fire).

menuKetemuEnemy :-
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
    asserta(peluang(P)).

run :-
    peluang(P), 
    P < 5,
    write('Kamu gagal lari, jadi kamu harus kalahkan tokemon liar itu!'),
    retract(peluang(P)).

run :-
    peluang(P),
    P >= 5,
    write('Kamu berhasil lari! Fyuh~'),
    retract(peluang(P)).

fight :-
    write('Pilih nama tokemon di inventory'), nl,
    statusInventory,
    read(Name),nl,
    inventory(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    asserta(myTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp)),
    write('Kamu memilih '), write(Name), write(' dengan health '), write(Health), nl,
    write('Sekarang ngapain?'), nl,
    write('- attack'), nl,
    write('- skill').

attack :-
    myTokemon(_,_,MyType,_,_,_,_,MyAttack,_,_),
    enemyTokemon(_,_,EnemyType,EnemyMaxHealth,_,EnemyHealth,_,_,_),
    superEffective(MyType,EnemyType),
    write('Kamu memilih attack! Dan super effective!'), nl,
    NewAttack is (MyAttack*1.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,NewEnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write('Sekarang giliran musuh!'),
    enemyAttack.

attack :-
    myTokemon(_,_,MyType,_,_,_,_,MyAttack,_,_),
    enemyTokemon(_,_,EnemyType,EnemyMaxHealth,_,EnemyHealth,_,_,_),
    \+superEffective(MyType,EnemyType),
    write('Kamu memilih attack! Tetapi tidak terlalu effective!'), nl,
    NewAttack is (MyAttack*0.95),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    write('Health musuh tersisa '), write(NewEnemyHealth), write('!'), nl,
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,NewEnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write('Sekarang giliran musuh!'),
    enemyAttack.

enemyAttack :-
    enemyTokemon(_,_,EnemyType,_,_,_,_,EnemyAttack,_),
    myTokemon(_,_,MyType,MyMaxHealth,_,MyHealth,_,_,_,_),
    superEffective(EnemyType,MyType),
    write('Enemy memilih attack! Dan super effective!'), nl,
    NewAttack is (EnemyAttack*1.5),
    NewMyHealth is (MyHealth-NewAttack),
    write('Health kamu tersisa '), write(NewMyHealth), write('!'), nl,
    retract(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,MyHealth,MyElement,MyAttack,MySpecial,Exp)),
    asserta(myTokemon(MyID,MyName,MyType,MyMaxHealth,MyLevel,NewMyHealth,MyElement,MyAttack,MySpecial,Exp)),
    write('Sekarang giliran kamu!').