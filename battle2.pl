:- dynamic(enemyTokemon/9).     /* enemyTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special) */
:- dynamic(myTokemon/10).       /* myTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special, Exp) */
:- dynamic(peluang/1).
:- dynamic(isRun/1).
:- dynamic(isSkill/1).
:- dynamic(isEnemySkill/1).
:- dynamic(isEnemyAlive/1).
:- dynamic(battle/1).
:- dynamic(isPick/1).

superEffective(fire, grass).
superEffective(fire, wind).
superEffective(water, fire).
superEffective(water, earth).
superEffective(grass, water).
superEffective(grass, electric).
superEffective(electric, water).
superEffective(electric, wind).
superEffective(wind, grass).
superEffective(wind, earth).
superEffective(earth, fire).
superEffective(earth, electric).

lessEffective(fire, water).
lessEffective(fire, earth).
lessEffective(water, grass).
lessEffective(water, electric).
lessEffective(grass, fire).
lessEffective(grass, wind).
lessEffective(electric, grass).
lessEffective(electric, earth).
lessEffective(wind, fire).
lessEffective(wind, electric).
lessEffective(earth, water).
lessEffective(earth, wind).

/* ---------- INTRO BATTLE ---------- */

enemyTriggered :-  
    random(7, 30, ID),
    tokedex(ID, Name, Type, MaxHealth, _, Element, Attack, Special),
    cekPanjang(Level),
    asserta(enemyTokemon(ID, Name, Type, MaxHealth, Level, _, Element, Attack, Special)),
    loop(Level,ID),
    retract(enemyTokemon(ID,Name2,Type,MaxHealth2,Level2,_,Element,Attack2,Special2)),
    Health is MaxHealth2,
    asserta(enemyTokemon(ID,Name2,Type,MaxHealth2,Level2,Health,Element,Attack2,Special2)),
    write('Kamu ketemu '), write(Name), write(' liar dengan level '), write(Level), write('!'), nl,
    write('Apa yang akan kamu lakukan?'), nl,
    write('- fight'), nl,
    write('- run'), nl,
    write('Ketik pilihan diakhiri titik, contoh: fight.'), nl,
    random(1, 10, P),
    asserta(peluang(P)),
    asserta(battle(1)),
    asserta(isEnemyAlive(1)).

legendaryTriggered1 :-
    ID is 100,
    tokedex(ID, Name, Type, MaxHealth, _, Element, Attack, Special),
    Health is MaxHealth,
    asserta(enemyTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special)),nl,
    write('Kamu bertemu Legendary Pokemon '), write(Name), write('!!!'), nl,nl,
    asserta(battle(1)),
    asserta(isEnemyAlive(1)),
    fight, !.

legendaryTriggered2 :-
    ID is 101,
    tokedex(ID, Name, Type, MaxHealth, _, Element, Attack, Special),
    Health is MaxHealth,
    asserta(enemyTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special)),nl,
    write('Kamu bertemu Legendary Pokemon '), write(Name), write('!!!'), nl,nl,
    asserta(battle(1)),
    asserta(isEnemyAlive(1)), 
    fight, !.

/* ---------- RUN ---------- */

/* ----- RUN GAGAL ----- */
run :-
    \+ isRun(_),
    battle(_),
    peluang(P), 
    P < 5,
    write('Kamu gagal lari, jadi kamu harus kalahkan tokemon liar itu!'), nl,
    asserta(isRun(1)),
    retract(peluang(P)),
    fight,
    !.
/* --------------------- */

/* ----- BELUM BATTLE ----- */
run :-
    \+ battle(_),
    write('Kamu belum bertemu tokemon liar. Cek penulisanmu ya...'),
    !.

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

/* ----- RUN SUDAH GAGAL SUDAH PILIH TOKEMON ----- */
run :-
    isRun(_),
    isPick(_),
    write('E-e-eh! Kamu sudah gagal run lo ya... Ayo, semangat~!'), nl,
    cont.

/* ----- RUN SUDAH GAGAL BELUM PILIH TOKEMON ----- */
run :-
    isRun(_),
    \+ isPick(_),
    write('E-e-eh! Kamu sudah gagal run lo ya... Ayo, semangat~!'), nl,
    write('Jangan lupa pilih tokemon!'), nl,
    fightChance.

/* ---------- PICK ---------- */
pick(X) :-
    \+ inventory(_,X,_,_,_,_,_,_,_,_),
    write('Kamu ga punya tokemon itu. Perhatikan daftar tokemon di inventori!'),
    fightChance, 
    !.

pick(X) :-
    inventory(ID,X,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    asserta(myTokemon(ID,X,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp)),
    write('Kamu memilih '), write(X), write(' dengan health '), write(Health), nl,
    asserta(isSkill(1)),
    cont, !.


/* ---------- FIGHT ---------- */
fight :-
    \+ battle(_),
    write('Kamu belum bertemu tokemon liar. Cek penulisanmu ya...'),
    !.

fight :-
    asserta(isRun(_)),
    battle(_),
    asserta(isEnemySkill(1)),
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    !.

fightChance :-
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    !.

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
    enemyTurn,
    !.

attackComment :-
    enemyTokemon(_, EnemyName, EnemyType, _, EnemyLevel, EnemyHealth, _, _, _),
    positionX(X),
    positionY(Y),
    EnemyHealth =< 0,
    write(EnemyName), write(' pingsan!'), nl,
    (
        EnemyType == legendary 
        -> 
            (
                isLegendary1(X,Y) 
                -> retract(legendary1(_,_))
                ; retract(legendary2(_,_))
            )
        ;
            
            retract(myTokemon(ID, _, _, _, _, MyHealth, _, _, _, _)),
            retract(inventory(ID, Name, Type, MaxHealth, Level, _, Element, Attack, Special, Exp)),
            maxExp(EnemyName, ExpGiven),
            NewExpGiven is EnemyLevel*ExpGiven,
            TempExp is Exp + NewExpGiven,
            asserta(inventory(ID, Name, Type, MaxHealth, Level, MyHealth, Element, Attack, Special, TempExp)),
            markLevelUp(ID,Level,TempExp),
            write('Apakah kamu mau menangkap '), write(EnemyName), write('?'), nl,
            write('- capture'), nl,
            write('- skip'), nl
    ),
    (
        (\+legendary1(_,_),\+legendary2(_,_))
        -> win
        ; retract(battle(1)),
        retract(isRun(_))
    ), !.

/* ----- ATTACK ----- */
attack :-
    \+ battle(_),
    write('Kamu belum bertemu tokemon liar. Cek penulisanmu ya...'),
    !.

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
    cekPanjang(X),
    X =:= 1,
    myTokemon(MyID, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth =< 0,
    retract(myTokemon(_, _, _, _, _, _, _, _, _, _)),
    delTokemon(MyID),
    write(MyName), write(' pingsan!'), nl,
    write('Kamu sudah tidak memiliki tokemon lagi di inventori!'), nl,
    retract(battle(_)),
    retract(run(_)),
    lose, 
    quit.

enemyAttackComment :-
    cekPanjang(X),
    X \== 1,
    myTokemon(MyID, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth =< 0,
    retract(myTokemon(_, _, _, _, _, _, _, _, _, _)),
    delTokemon(MyID),
    write(MyName), write(' pingsan!'), nl,
    write('Pilih Tokemon yang lain di inventorimu'), nl,
    fightChance,
    !.

enemyAttackComment :-
    myTokemon(_, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth > 0,
    write('Health '), write(MyName), write(' tersisa '), write(MyHealth),
    !.

/* ---------- SKILL ATTACK ---------- */
skill :-
    \+ battle(_),
    write('Kamu belum bertemu tokemon liar. Cek penulisanmu ya...'),
    !.

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
    namaSkill(MyName, X), 
    write(MyName), write(' menggunakan '), write(X), write('!'), nl,
    retract(isSkill(_)),
    attackComment,!.

/* ----- LESS EFFECTIVE ----- */
skill :-
    \+ isSkill(_),
    write('Kamu sudah memakai skill. Pilih yang lain ya...'), nl,
    !.

skill :-
    battle(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, _, MySpecial, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    lessEffective(MyElement, EnemyElement),
    NewSpecial is (MySpecial*0.5),
    NewEnemyHealth is (EnemyHealth-NewSpecial),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    namaSkill(MyName, X),
    write(MyName), write(' menggunakan '), write(X), write('!'), nl,
    retract(isSkill(_)),
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
    namaSkill(MyName, X),
    write(MyName), write(' menggunakan '), write(X), write('!'), nl,
    retract(isSkill(_)),
    attackComment,!.

/* ---------- ENEMY TURN ---------- */
enemyTurn :-
    random(1,4,X),
    (X =< 2 ->
        enemyAttack
    ; enemySkill
    ),
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

/* ---------- ENEMY SKILL ---------- */
enemySkill :-
    \+ isEnemySkill(_),
    enemyAttack.
    
/* ----- SUPER EFFECTIVE ----- */
enemySkill :-
    enemyTokemon(_, EnemyName, _, _, _, _, EnemyElement, _, EnemySkill),
    myTokemon(_, _, _, _, _, MyHealth, MyElement, _, _, _),
    superEffective(EnemyElement, MyElement),
    NewSkill is (EnemySkill*1.5),
    NewMyHealth is (MyHealth-NewSkill),
    retract(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, MyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    asserta(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, NewMyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    namaSkill(EnemyName, X),
    write(EnemyName), write(' menggunakan '), write(X), write('!'), nl,
    retract(isEnemySkill(_)),
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
    namaSkill(EnemyName, X),
    write(EnemyName), write(' menggunakan '), write(X), write('!'), nl,
    retract(isEnemySkill(_)),
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
    namaSkill(EnemyName, X),
    write(EnemyName), write(' menggunakan '), write(X), write('!'), nl,
    retract(isEnemySkill(_)),
    enemyAttackComment,
    !.

/* ---------- DROP ---------- */
drop(Name) :-
    \+ tokedex(_, Name, _, _, _, _, _, _),
    write('Kamu ga punya tokemon itu. Perhatikan daftar tokemon di inventori!'),nl,
    statusInventory,
    !.

drop(Name) :-
    tokedex(ID, Name, _, _, _, _, _, _),
    delTokemon(ID),
    addTokemon(EnemyID),
    write(Name), write(' berhasil ditukar dengan '), write(EnemyName), nl,
    write(Name), write(' dibebaskan ke habitatnya kembali.'), nl, 
    retract(battle(_)),
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
    retract(isRun(_)),
    !.

skip :-
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(EnemyName), write(' terbangun dan segera berlari ke semak-semak, menghilang dari pandanganmu.'), nl,
    write('Kamu pun melanjutkan perjalananmu.'), 
    retract(battle(_)),
    retract(isRun(_)),
    !.

/* ---------- WIN ---------- */
win :-
    write('$$\\     $$\\  $$$$$$\\  $$\\   $$\\       $$\\      $$\\ $$$$$$\\ $$\\   $$\\ '), nl,
    write('\\$$\\   $$  |$$  __$$\\ $$ |  $$ |      $$ | $\\  $$ |\\_$$  _|$$$\\  $$ |'), nl,
    write(' \\$$\\ $$  / $$ /  $$ |$$ |  $$ |      $$ |$$$\\ $$ |  $$ |  $$$$\\ $$ |'), nl,
    write('  \\$$$$  /  $$ |  $$ |$$ |  $$ |      $$ $$ $$\\$$ |  $$ |  $$ $$\\$$ |'), nl,
    write('   \\$$  /   $$ |  $$ |$$ |  $$ |      $$$$  _$$$$ |  $$ |  $$ \\$$$$ |'), nl,
    write('    $$ |    $$ |  $$ |$$ |  $$ |      $$$  / \\$$$ |  $$ |  $$ |\\$$$ |'), nl,
    write('    $$ |     $$$$$$  |\\$$$$$$  |      $$  /   \\$$ |$$$$$$\\ $$ | \\$$ |'), nl,
    write('    \\__|     \\______/  \\______/       \\__/     \\__|\\______|\\__|  \\__|'), nl,
    quit.

/* ---------- LOSE ---------- */
lose :-
    write('▓██   ██▓ ▒█████   █    ██     ██▓     ▒█████    ██████ ▓█████ '), nl,
    write(' ▒██  ██▒▒██▒  ██▒ ██  ▓██▒   ▓██▒    ▒██▒  ██▒▒██    ▒ ▓█   ▀ '), nl,
    write('  ▒██ ██░▒██░  ██▒▓██  ▒██░   ▒██░    ▒██░  ██▒░ ▓██▄   ▒███   '), nl,
    write('  ░ ▐██▓░▒██   ██░▓▓█  ░██░   ▒██░    ▒██   ██░  ▒   ██▒▒▓█  ▄ '), nl,
    write('  ░ ██▒▓░░ ████▓▒░▒▒█████▓    ░██████▒░ ████▓▒░▒██████▒▒░▒████▒'), nl,
    write('   ██▒▒▒ ░ ▒░▒░▒░ ░▒▓▒ ▒ ▒    ░ ▒░▓  ░░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░░░ ▒░ ░'), nl,
    write(' ▓██ ░▒░   ░ ▒ ▒░ ░░▒░ ░ ░    ░ ░ ▒  ░  ░ ▒ ▒░ ░ ░▒  ░ ░ ░ ░  ░'), nl,
    write(' ▒ ▒ ░░  ░ ░ ░ ▒   ░░░ ░ ░      ░ ░   ░ ░ ░ ▒  ░  ░  ░     ░   '), nl,
    write(' ░ ░         ░ ░     ░            ░  ░    ░ ░        ░     ░  ░'), nl,
    write(' ░ ░                                          '), nl,
    quit.