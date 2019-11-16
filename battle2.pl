:- dynamic(enemyTokemon/9).     /* enemyTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special) */
:- dynamic(myTokemon/10).       /* myTokemon(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special, Exp) */
:- dynamic(peluang/1).
:- dynamic(isEnemySkill/1).
:- dynamic(isEnemyAlive/1).
:- dynamic(ableCaptured/1).
:- dynamic(isPick/1).
:- dynamic(isRun/1).
:- dynamic(isFight/1).
:- dynamic(isSkill/1).
:- dynamic(temp/1).

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

/* ---------- INTRO isEnemyAlive ---------- */

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
    asserta(isEnemyAlive(1)).

legendaryTriggered1 :-
    ID is 100,
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,
    asserta(enemyTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special)),nl,
    write('Kamu bertemu Legendary Pokemon '), write(Name), write('!!!'), nl,nl,
    asserta(isEnemyAlive(1)),
    fight, !.

legendaryTriggered2 :-
    ID is 101,
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,    
    asserta(enemyTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special)),nl,
    write('Kamu bertemu Legendary Pokemon '), write(Name), write('!!!'), nl,nl,
    asserta(isEnemyAlive(1)), 
    fight, !.

/* ---------- RUN ---------- */

/* ----- BELUM isEnemyAlive ----- */
run :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu tokemon liar. Mau lari darimana? Kenyataan?'),
    !.
/* ------------------------ */

/* ----- RUN GAGAL ----- */
run :-
    \+ isRun(_),
    isEnemyAlive(_),
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
    isEnemyAlive(_),
    peluang(P),
    P >= 5,
    write('Kamu berhasil lari! Fyuh~'),
    retract(peluang(P)),
    retract(isEnemyAlive(_)),
    retract(enemyTokemon(_, _, _, _, _, _, _, _, _)),
    retract(isEnemySkill(_)),
    !.
/* ------------------------ */

/* ----- RUN SUDAH GAGAL BELUM PILIH TOKEMON ----- */
run :-
    isRun(_),
    \+ isPick(_),
    write('E-e-eh! Kamu sudah gagal run lo ya... Ayo, semangat~!'), nl,
    write('Jangan lupa pilih tokemon!'), nl,
    fightChance.
/* ------------------------------------------------ */

/* ----- RUN SUDAH GAGAL SUDAH PILIH TOKEMON ----- */
run :-
    isRun(_),
    isPick(_),
    write('E-e-eh! Kamu sudah gagal run lo ya... Ayo, semangat~!'), nl,
    !.
/* ----------------------------------------------- */

/* ---------- PICK ---------- */
/* ----- BELOM KETEMU TOKEMON LIAR ----- */
pick(X) :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu tokemon liar, sehingga kamu tidak bisa memilih tokemon dari inventori.'), nl,
    write('Start atau jalan sampai bertemu tokemon liar. Good luck~!'), nl,
    !.
/* -------------------------------------- */

/* ----- UDA KETEMU TOKEMON LIAR TAPI BLOM PILIH FIGHT ----- */
pick(X) :-
    \+isFight(_),
    write('Pilih fight dulu mas'),nl,
    !.
/* --------------------------------------------------------- */

/* ----- UDA PICK INPUT PICK LAGI ----- */
pick(X) :-
    isPick(_),
    isFight(_),
    write('Weh masa tokemonmu yang sekarang mau ditinggal :('),
    !.
/* ------------------------------------- */

/* ----- PICK TOKEMON YG GA ADA DI INVENTORI ----- */
pick(X) :-
    isEnemyAlive(_),
    isFight(_),
    \+ inventory(_,X,_,_,_,_,_,_,_,_),
    write('Kamu ga punya tokemon itu. Perhatikan daftar tokemon di inventori!'),
    fightChance, 
    !.
/* ------------------------------------------------ */

/* ----- PICK BERHASIL ----- */
pick(X) :-
    isEnemyAlive(_),
    isFight(_),
    \+ isPick(_),
    inventory(ID,X,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp),
    asserta(myTokemon(ID,X,Type,MaxHealth,Level,Health,Element,Attack,Special,Exp)),
    write('Kamu memilih '), write(X), write(' dengan health '), write(Health), nl,
    asserta(isSkill(1)),
    asserta(isPick(1)),
    cont, !.
/* -------------------------- */

/* ---------- FIGHT ---------- */
/* ----- BLOM KETEMU TOKEMON ---- */
fight :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu tokemon liar. Mau nyerang apa mas?'),
    !.
/* ------------------------------ */

/* ----- KETEMU TOKEMON UDA PICK TP FIGHT LAGI ----- */
fight :-
    isFight(_),
    isEnemyAlive(_),
    write('Kamu lagi fight enemy-nya, bambang. Semangat ya~!'), nl,
    !.

/* ----- FIGHT BERHASIL ----- */
fight :-
    asserta(isRun(1)),
    asserta(isFight(1)),
    isEnemyAlive(_),
    asserta(isEnemySkill(1)),
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    !.
/* -------------------------- */

/* ----- KALO TOKEMON UDA PINGSAN TERUS GANTI TOKEMON ----- */
fightChance :-
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    !.
/* -------------------------------------------------------- */

/* ---------- CONTINUE/END TURN ---------- */
cont :-
    write('Sekarang ngapain nih?'), nl,
    write('- attack'), nl,
    write('- skill'), nl,
    !.

/* ---------- ATTACK ---------- */

/* ----- COMMENT ----- */
/* ----- NORMAL ----- */
attackComment :-
    enemyTokemon(_, EnemyName, _, _, _, EnemyHealth, _, _, _),
    EnemyHealth > 0,
    write('Health '), write(EnemyName), write(' tersisa '), write(EnemyHealth), nl,
    write('Sekarang giliran musuh!'), nl,
    write('...'), nl,
    sleep(1),
    enemyTurn,
    !.
/* ------------------ */
/* ----- ENEMY PINGSAN ----- */
attackComment :-
    enemyTokemon(ID, EnemyName, EnemyType, _, EnemyLevel, EnemyHealth, _, _, _),
    EnemyHealth =< 0,
    write(EnemyName), write(' pingsan!'), nl,
    asserta(ableCaptured(1)),
    (
        isEnemySkill(_)
        -> retract(isEnemySkill(_))
        ; tokedex(A,_,_,_,_,_,_,_)
    ),
    (
        EnemyType == legendary 
        -> 
            legendary,
            retract(enemyTokemon(_,_,_,_,_,_,_,_,_))
        ;
            retract(myTokemon(MyID, _, _, _, _, MyHealth, _, _, _, _)),
            retract(inventory(MyID, Name, Type, MaxHealth, Level, _, Element, Attack, Special, Exp)),
            maxExp(EnemyName, ExpGiven),
            NewExpGiven is EnemyLevel*ExpGiven,
            TempExp is Exp + NewExpGiven,
            asserta(inventory(MyID, Name, Type, MaxHealth, Level, MyHealth, Element, Attack, Special, TempExp)),
            write(Name), write(' '),
            markLevelUp(MyID,Level,TempExp),
            write('Apakah kamu mau menangkap '), write(EnemyName), write('?'), nl,
            write('- capture'), nl,
            write('- skip'), nl
    ),
    !.

/* ENEMY LEGENDARY */
legendary :-
    enemyTokemon(ID, _, _, _, _, _, _, _, _),
    positionX(X),
    positionY(Y),
    (
        isLegendary1(X,Y) 
        -> 
            (
                retract(legendary1(_,_)), retract(legendary(ID,_,_,_,_,_,_,_,_))
            )
        ; 
            (
                retract(legendary2(_,_)), retract(legendary(ID,_,_,_,_,_,_,_,_))
            )
    ),
    (
        (\+legendary1(_,_),\+legendary2(_,_))
        -> win
        ; 
        (
            retract(isEnemyAlive(_)),
            retract(isFight(_)),
            retract(isPick(_)),
            retract(isRun(_)),
            retract(isSkill(_))
        )
    ),
    !.

/* ----------------------- */

/* ----- BLOM KETEMU TOKEMON LIAR ----- */
attack :-
    \+ isEnemyAlive(_),
    write('Blom ketemu tokemon liar cuk'), nl,
    !.
/* ------------------------------------ */

/* ----- BLOM PICK TOKEMON ----- */
attack :-
    isEnemyAlive(_),
    \+ isPick(_),
    write('Pilih tokemon dulu brow'), nl,
    !.
/* ----------------------------- */

/* ----- SUPER EFFECTIVE ----- */
attack :-
    isEnemyAlive(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, MyAttack, _, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    superEffective(MyElement, EnemyElement),
    NewAttack is (MyAttack*1.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(MyName), write(' menggunakan attack! Dan itu super effective!'), nl,
    attackComment,!.
/* --------------------------- */

/* ----- LESS EFFECTIVE ----- */
attack :-
    isEnemyAlive(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, MyAttack, _, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    lessEffective(MyElement, EnemyElement),
    NewAttack is (MyAttack*0.5),
    NewEnemyHealth is (EnemyHealth-NewAttack),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(MyName), write(' menggunakan attack! Tapi itu tidak terlalu effective!'), nl,
    attackComment,!.
/* --------------------------- */

/* ----- ELEMEN SAMA ----- */
attack :-
    isEnemyAlive(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, MyAttack, _, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    \+superEffective(MyElement,EnemyElement),
    \+lessEffective(MyElement,EnemyElement),
    NewEnemyHealth is (EnemyHealth-MyAttack),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    write(MyName), write(' menggunakan attack!'), nl,
    attackComment,!.
/* ------------------------ */

/* ---------- SKILL ---------- */

/* ----- BLOM KETEMU ENEMY ----- */
skill :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu tokemon liar. Jangan napsu nyerang mas. '),
    !.
/* ----------------------------- */

/* ----- SUDAH PAKAI SKILL ----- */
skill :-
    \+ isSkill(_),
    write('Kamu sudah memakai skill. Pilih yang lain ya...'), nl,
    !.
/* ----------------------------- */

/* ----- SUPER EFFECTIVE ----- */
skill :-
    isEnemyAlive(_),
    isSkill(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, _, MySpecial, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    superEffective(MyElement, EnemyElement),
    NewSpecial is (MySpecial*1.5),
    NewEnemyHealth is (EnemyHealth-NewSpecial),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    namaSkill(MyName, SkillName), 
    write(MyName), write(' menggunakan '), write(SkillName), write('!'), nl,
    write('It\'s super effective!'), nl,
    retract(isSkill(_)),
    attackComment,!.
/* --------------------------- */

/* ----- LESS EFFECTIVE ----- */
skill :-
    isEnemyAlive(_),
    isSkill(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, _, MySpecial, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    lessEffective(MyElement, EnemyElement),
    NewSpecial is (MySpecial*0.5),
    NewEnemyHealth is (EnemyHealth-NewSpecial),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    namaSkill(MyName, SkillName),
    write(MyName), write(' menggunakan '), write(SkillName), write('!'), nl,
    write('It\'s not very effective.'), nl,
    retract(isSkill(_)),
    attackComment,!.
/* -------------------------- */

/* ----- ELEMEN SAMA ----- */
skill :-
    isEnemyAlive(_),
    isSkill(_),
    myTokemon(_, MyName, _, _, _, _, MyElement, _, MySpecial, _),
    enemyTokemon(_, _, _, _, _, EnemyHealth, EnemyElement, _, _),
    \+ superEffective(EnemyElement, MyElement),
    \+ lessEffective(EnemyElement, MyElement),
    NewEnemyHealth is (EnemyHealth-MySpecial),
    retract(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,EnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    asserta(enemyTokemon(EnemyID,EnemyName,EnemyType,EnemyMaxHealth,EnemyLevel,NewEnemyHealth,EnemyElement,EnemyAttack,EnemySpecial)),
    namaSkill(MyName, SkillName),
    write(MyName), write(' menggunakan '), write(SkillName), write('!'), nl,
    retract(isSkill(_)),
    attackComment,!.
/* ------------------------ */

/* ---------- ENEMY TURN ---------- */
enemyTurn :-
    random(1,4,X),
    (X =< 2 ->
        enemyAttack
    ; enemySkill
    ),
    !.

/* ---------- ENEMY ATTACK ----------- */

/* ----- ENEMY ATTACK COMMENT ----- */
enemyAttackComment :-
    myTokemon(_, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth > 0,
    write('Health '), write(MyName), write(' tersisa '), write(MyHealth),
    !.

enemyAttackComment :-
    cekPanjang(X),
    X =:= 1,
    myTokemon(MyID, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth =< 0,
    retract(myTokemon(_, _, _, _, _, _, _, _, _, _)),
    retract(enemyTokemon(_, _, _, _, _, _, _, _, _)),
    delTokemon(MyID),
    write(MyName), write(' pingsan!'), nl,
    write('Kamu sudah tidak memiliki tokemon lagi di inventori!'), nl,
    lose.

enemyAttackComment :-
    cekPanjang(X),
    X \== 1,
    myTokemon(MyID, MyName, _, _, _, MyHealth, _, _, _, _),
    MyHealth =< 0,
    retract(myTokemon(_, _, _, _, _, _, _, _, _, _)),
    write(MyID),
    delTokemon(MyID),
    write(MyName), write(' pingsan!'), nl,
    write('Pilih Tokemon yang lain di inventorimu'), nl,
    retract(isPick(_)),
    fightChance,
    !.
    


/* ----- ENEMY ATTACK ----- */

/* ----- SUPER EFFECTIVE ----- */
enemyAttack :-
    enemyTokemon(_, EnemyName, _, _, _, _, EnemyElement, EnemyAttack, _),
    myTokemon(_, _, _, _, _, MyHealth, MyElement, _, _, _),
    superEffective(EnemyElement, MyElement),
    NewAttack is (EnemyAttack*1.5),
    NewMyHealth is (MyHealth-NewAttack),
    retract(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, MyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    asserta(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, NewMyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    write(EnemyName), write(' menggunakan attack!'), nl,
    write('It\'s super effective!'), nl,
    enemyAttackComment,
    !.
/* ----------------------------- */

/* ----- LESS EFFECTIVE ----- */
enemyAttack :-
    enemyTokemon(_, EnemyName, _, _, _, _, EnemyElement, EnemyAttack, _),
    myTokemon(_, _, _, _, _, MyHealth, MyElement, _, _, _),
    lessEffective(EnemyElement, MyElement),
    NewAttack is (EnemyAttack*0.5),
    NewMyHealth is (MyHealth-NewAttack),
    retract(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, MyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    asserta(myTokemon(MyID, MyName, MyType, MyMaxHealth, MyLevel, NewMyHealth, MyElement, MyAttack, MySpecial, MyExp)),
    write(EnemyName), write(' menggunakan attack!'), nl,
    write('But it\'s less effective'), nl,
    enemyAttackComment,
    !.
/* ---------------------------- */

/* ----- ELEMEN SAMA ----- */
enemyAttack :-
    enemyTokemon(_, EnemyName, _, _, _, _, EnemyElement, EnemyAttack, _),
    myTokemon(_, _, _, _, _, MyHealth, MyElement, _, _, _),
    \+superEffective(EnemyElement,MyElement),
    \+lessEffective(EnemyElement,MyElement),
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
    write('It\'s super effective!'), nl,
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
    write('It\'s not very effective.'), nl,
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
    \+ isEnemyAlive(_),
    write('Tidak ada tokemon baru yang mau ditambahkan. Ngapain dibuang tokemonmu?').

drop(Name) :-
    \+ inventory(_, Name, _, _, _, _, _, _, _, _),
    isEnemyAlive(_),
    write('Kamu ga punya tokemon itu. Perhatikan daftar tokemon di inventori!'),nl,
    statusInventory,
    !.

drop(Name) :-
    tokedex(ID, Name, _, _, _, _, _, _),
    retract(temp(EnemyID)),
    delTokemon(ID),
    addTokemon(EnemyID),
    tokedex(EnemyID, EnemyName, _, _, _, _, _, _),
    write(Name), write(' berhasil ditukar dengan '), write(EnemyName), nl,
    write(Name), write(' dibebaskan ke habitatnya kembali.'), nl, 
    retract(isEnemyAlive(_)),
    retract(isRun(_)),
    retract(isFight(_)),
    (
        isEnemySkill(_)
        -> retract(isEnemySkill(_))
        ; tokedex(ID, _, _, _, _, _, _, _)
    ),
    retract(isPick(_)),
    !.

/* ---------- CAPTURE ---------- */
capture :-
    \+ ableCaptured(_),
    write('Buat enemy pingsan dulu baru bisa sekip'), nl,
    !.

capture :-
    \+ isEnemyAlive(_),
    write('Uda start blom? Blom ketemu tokemon liar tuh, mau nangkep apa bos?'), nl,
    !.

capture :-
    ableCaptured(_),
    \+ isFull,
    isEnemyAlive(_),
    retract(enemyTokemon(EnemyID, EnemyName, _, _, _, _, _, _, _)),
    addTokemon(EnemyID),
    write(EnemyName), write(' berhasil dimasukkan ke inventorimu!'), nl,
    retract(isEnemyAlive(_)),
    retract(isRun(_)),
    retract(isFight(_)),
    retract(ableCaptured(_)),
    retract(isPick(_)),
    retract(isSkill(_)),
    !.

capture :-
    ableCaptured(_),
    isEnemyAlive(_),
    isFull,
    retract(enemyTokemon(EnemyID, EnemyName, _, _, _, _, _, _, _)),
    asserta(temp(EnemyID)),
    write('Inventorimu penuh! Pilih satu tokemonmu untuk ditukar dengan '), write(EnemyName), nl,
    statusInventory, nl,
    write('Buang tokemonmu dengan perintah \'drop(nama tokemon)\' '), nl,
    !.

/* ---------- SKIP ---------- */
skip :-
    \+ ableCaptured(_),
    write('Buat enemy pingsan dulu baru bisa sekip'), nl,
    !.

skip :-
    \+ isFight(_),
    write('Uda start blom? Belum ketemu tokemon liar tu, mau sekip apa bos? Hearing cakahim?'), nl,
    !.

skip :-
    ableCaptured(_),
    isEnemyAlive(_),
    retract(enemyTokemon(_,EnemyName,_,_,_,_,_,_,_)),
    write(EnemyName), write(' terbangun dan segera berlari ke semak-semak, menghilang dari pandanganmu.'), nl,
    write('Kamu pun melanjutkan perjalananmu.'), 
    retract(isEnemyAlive(_)),
    retract(isRun(_)),
    retract(isFight(_)),
    retract(ableCaptured(_)),
    retract(isPick(_)),
    retract(isSkill(_)),
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
    retract(isEnemyAlive(_)),
    retract(isRun(_)),
    retract(isFight(_)),
    retract(isPick(_)),
    quit.

/* ---------- LOSE ---------- */
lose :-
    retract(isEnemyAlive(_)),
    retract(isRun(_)),
    retract(isFight(_)),
    retract(isPick(_)),
    write('@@@ @@@   @@@@@@   @@@  @@@     @@@        @@@@@@    @@@@@@   @@@@@@@@  '), nl,
    write('@@@ @@@  @@@@@@@@  @@@  @@@     @@@       @@@@@@@@  @@@@@@@   @@@@@@@@ '), nl, 
    write('@@! !@@  @@!  @@@  @@!  @@@     @@!       @@!  @@@  !@@       @@!      '), nl, 
    write('!@! @!!  !@!  @!@  !@!  @!@     !@!       !@!  @!@  !@!       !@!      '), nl, 
    write(' !@!@!   @!@  !@!  @!@  !@!     @!!       @!@  !@!  !!@@!!    @!!!:!   '), nl, 
    write('  @!!!   !@!  !!!  !@!  !!!     !!!       !@!  !!!   !!@!!!   !!!!!:   '), nl, 
    write('  !!:    !!:  !!!  !!:  !!!     !!:       !!:  !!!       !:!  !!:      '), nl, 
    write('  :!:    :!:  !:!  :!:  !:!      :!:      :!:  !:!      !:!   :!:      '), nl, 
    write('   ::    ::::: ::  ::::: ::      :: ::::  ::::: ::  :::: ::    :: :::: '), nl, 
    write('   :      : :  :    : :  :      : :: : :   : :  :   :: : :    : :: ::  '), nl,
    quit.