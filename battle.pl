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
    write('Kamu bertemu Tokemon liar!'), nl, nl,
    sleep(0.5),
    write(Name2), nl,
    write('Element: '), write(Element), nl,
    write('Level: '), write(Level2), nl,
    write('Health: '), write(MaxHealth2), nl, nl,
    sleep(0.5),
    write('Apa yang akan kamu lakukan? Ketik \'fight.\' atau \'run.\' .'),
    random(1, 10, P),
    asserta(peluang(P)),
    asserta(isEnemyAlive(1)).

legendaryTriggered1 :-
    ID is 100,
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,
    asserta(enemyTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special)),nl,
    write('Kamu bertemu Legendary Tokemon !!!'), nl,nl,
    sleep(0.5),
    write(Name), nl,
    write('Element: '), write(Element), nl,
    write('Level: '), write(Level), nl,
    write('Health: '), write(Health), nl,
    asserta(isEnemyAlive(1)),
    fight, !.

legendaryTriggered2 :-
    ID is 101,
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,    
    asserta(enemyTokemon(ID,Name,Type,MaxHealth,Level,Health,Element,Attack,Special)),nl,
    write('Kamu bertemu Legendary Tokemon !!!'), nl,nl,    
    sleep(0.5),
    write(Name), nl,
    write('Element: '), write(Element), nl,
    write('Level: '), write(Level), nl,
    write('Health: '), write(Health), nl,
    asserta(isEnemyAlive(1)), 
    fight, !.

/* ---------- RUN ---------- */

/* ----- BELUM isEnemyAlive ----- */
run :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu Tokemon liar. Mau lari darimana? Kenyataan?'),
    !.
/* ------------------------ */

/* ----- RUN GAGAL ----- */
run :-
    \+ isRun(_),
    isEnemyAlive(_),
    peluang(P), 
    P < 5,
    write('Kamu gagal lari, jadi kamu harus kalahkan Tokemon liar itu!'), nl,
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
    (
        isEnemySkill(_) ->
        retract(isEnemySkill(_))
        ;
        lebar(X)
    )
    , !.
/* ------------------------ */

/* ----- RUN SUDAH GAGAL BELUM PILIH TOKEMON ----- */
run :-
    isRun(_),
    \+ isPick(_),
    write('E-e-eh! Kamu sudah gagal run lo ya... Ayo, semangat~!'), nl,
    write('Jangan lupa pilih Tokemon!'), nl,
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
    write('Kamu belum bertemu Tokemon liar, sehingga kamu tidak bisa memilih Tokemon dari inventori.'), nl,
    write('Start atau jalan sampai bertemu Tokemon liar. Good luck~!'), nl,
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
    write('Kamu ga punya Tokemon itu. Perhatikan daftar Tokemon di inventori!'),
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
    nl,
    write('Go, '), write(X),write('!'), nl,nl,
    sleep(1),
    write('Type: '), write(Element), nl,
    write('Level: '), write(Level), nl,
    write('Health: '), write(Health), nl,
    sleep(0.5),
    asserta(isSkill(1)),
    asserta(isPick(1)),
    cont, !.
/* -------------------------- */

/* ---------- FIGHT ---------- */
/* ----- BLOM KETEMU TOKEMON ---- */
fight :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu Tokemon liar. Mau nyerang apa mas?'),
    !.
/* ------------------------------ */

/* ----- KETEMU TOKEMON UDA PICK TP FIGHT LAGI ----- */
fight :-
    isFight(_),
    isEnemyAlive(_),
    write('Kamu lagi fight enemy-nya, bambank. Semangat ya~!'), nl,
    !.

/* ----- FIGHT BERHASIL ----- */
fight :-
    asserta(isRun(1)),
    asserta(isFight(1)),
    isEnemyAlive(_),
    asserta(isEnemySkill(1)),
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    write('Pilih Tokemon dengan menggunakan pick(Nama Tokemon).'), nl,
    !.
/* -------------------------- */

/* ----- KALO TOKEMON UDA PINGSAN TERUS GANTI TOKEMON ----- */
fightChance :-
    write('Tokemon yang tersedia:'), nl,
    statusInventory,
    write('Pilih Tokemon dengan menggunakan pick(Nama Tokemon).'), nl,
    !.
/* -------------------------------------------------------- */

/* ---------- CONTINUE/END TURN ---------- */
cont :-
    myTokemon(_, Name,_,_,_,_,_,_,_,_),
    write('Apa yang harus '), write(Name), write(' lakukan?'), nl,
    write('- attack'), nl,
    write('- skill'), nl,
    !.

/* ---------- ATTACK ---------- */

/* ----- COMMENT ----- */
/* ----- NORMAL ----- */
attackComment :-
    enemyTokemon(_, EnemyName, _, _, _, EnemyHealth, _, _, _),
    EnemyHealth > 0,
    write('Health '), write(EnemyName), write(' tersisa '), write(EnemyHealth), write('!'), nl,
    sleep(0.5),
    write('Sekarang giliran musuh!'), nl,
    write('...'), nl,
    sleep(1),
    enemyTurn,
    !.
/* ------------------ */
/* ----- ENEMY PINGSAN ----- */
attackComment :-
    enemyTokemon(_, EnemyName, EnemyType, _, EnemyLevel, EnemyHealth, _, _, _),
    EnemyHealth =< 0,
    write(EnemyName), write(' pingsan!'), nl,
    sleep(0.5),
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
    write('Blom ketemu Tokemon liar cuk!'), nl,
    !.
/* ------------------------------------ */

/* ----- BLOM PICK TOKEMON ----- */
attack :-
    isEnemyAlive(_),
    \+ isPick(_),
    write('Pilih Tokemon dulu brow!'), nl,
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
    write(MyName), write(' menggunakan attack!'), nl,
    sleep(0.5),
    write('It\'s super effective!'), nl,
    sleep(0.5),
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
    write(MyName), write(' menggunakan attack!'), nl,
    sleep(0.5),
    write('It\'s not very effective.'), nl,
    sleep(0.5),
    attackComment, !.
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
    sleep(0.5),
    attackComment,!.
/* ------------------------ */

/* ---------- SKILL ---------- */

/* ----- BLOM KETEMU ENEMY ----- */
skill :-
    \+ isEnemyAlive(_),
    write('Kamu belum bertemu Tokemon liar. Jangan napsu nyerang mas. '),
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
    sleep(0.5),
    write('It\'s super effective!'), nl,
    sleep(0.5),
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
    sleep(0.5),
    write('It\'s not very effective.'), nl,
    sleep(0.5),
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
    sleep(0.5),
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
    write('Health '), write(MyName), write(' tersisa '), write(MyHealth), write('!'), nl,
    sleep(0.5),
    cont,
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
    sleep(0.5),
    write('Kamu sudah tidak memiliki tokemon lagi di inventori!'), nl,
    sleep(0.5),
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
    sleep(0.5),
    write('Pilih Tokemon yang lain di inventorimu!'), nl,
    retract(isPick(_)),
    fightChance, cont,
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
    sleep(0.5),
    write('It\'s super effective!'), nl,
    sleep(0.5),
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
    sleep(0.5),
    write('It\'s not very effective.'), nl,
    sleep(0.5),
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
    sleep(0.5),
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
    sleep(0.5),
    write('It\'s super effective!'), nl,
    sleep(0.5),
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
    sleep(0.5),
    write('It\'s not very effective.'), nl,
    sleep(0.5),
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
    sleep(0.5),
    retract(isEnemySkill(_)),
    enemyAttackComment,
    !.

/* ---------- DROP ---------- */
drop(_) :-
    \+ isEnemyAlive(_),
    write('Tidak ada Tokemon baru yang mau ditambahkan. Ngapain dibuang tokemonmu?').

drop(Name) :-
    \+ inventory(_, Name, _, _, _, _, _, _, _, _),
    isEnemyAlive(_),
    write('Kamu ga punya Tokemon itu. Perhatikan daftar Tokemon di inventori!'),nl,
    statusInventory,
    !.

drop(Name) :-
    tokedex(ID, Name, _, _, _, _, _, _),
    retract(temp(EnemyID)),
    delTokemon(ID),
    addTokemon(EnemyID),
    tokedex(EnemyID, EnemyName, _, _, _, _, _, _),
    write(Name), write(' berhasil ditukar dengan '), write(EnemyName), write('!'), nl,
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
    write('Buat enemy pingsan dulu baru bisa sekip!'), nl,
    !.

capture :-
    \+ isEnemyAlive(_),
    write('Uda start blom? Blom ketemu Tokemon liar tuh, mau nangkep apa bos?'), nl,
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
    (
        isSkill(_) ->
        retract(isSkill(_))
        ;
        lebar(X)
    )
    ,
    (
        isEnemySkill(_) ->
        retract(isEnemySkill(_))
        ; lebar(X)  
    ),
    !.

capture :-
    ableCaptured(_),
    isEnemyAlive(_),
    isFull,
    retract(enemyTokemon(EnemyID, EnemyName, _, _, _, _, _, _, _)),
    asserta(temp(EnemyID)),
    write('Inventorimu penuh! Pilih satu Tokemonmu untuk ditukar dengan '), write(EnemyName), write('.'), nl,
    statusInventory, nl,
    write('Buang tokemonmu dengan perintah \'drop(nama Tokemon).\' .'), nl,
    !.

/* ---------- SKIP ---------- */
skip :-
    \+ ableCaptured(_),
    write('Buat enemy pingsan dulu baru bisa sekip!'), nl,
    !.

skip :-
    \+ isEnemyAlive(_),
    write('Uda start blom? Belum ketemu Tokemon liar tu, mau sekip apa bos? Kelas LogKom?'), nl,
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
    (
        isSkill(_) ->
        retract(isSkill(_))
        ;
        lebar(X)
    )
    ,
    (
        isEnemySkill(_) ->
        retract(isEnemySkill(_))
        ; lebar(X)  
    ),
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
    retract(isEnemyAlive(_)),
    retract(isRun(_)),
    retract(isFight(_)),
    retract(isPick(_)),
    quit.