:- dynamic(init/1).          /* Mark game dimulai */
:- dynamic(player/1).

:- include('command.pl').
:- include('leveling.pl').
:- include('player.pl').
:- include('tokedex.pl').
:- include('battle.pl').
:- include('map.pl').
:- include('evolution.pl.').


title :-
    write(' ____  _____  _  _  ____  __  __  _____  _  _ '),nl,
    write('(_  _)(  _  )( )/ )( ___)(  \\/  )(  _  )( \\( )'),nl,
    write('  )(   )(_)(  )  (  )__)  )    (  )(_)(  )  ( '),nl,
    write(' (__) (_____)(_)\\_)(____)(_/\\/\\_)(_____)(_)\\_)'),nl,nl,
    write('Gotta catch em all!'),nl,
    write('Hello there! Welcome to the world of Tokemon! My name is Aril!'),nl,
    sleep(0.5),
    write('People call me the Tokemon Professor! This world is inhabited by'),nl,
    sleep(0.5),
    write('creatures called Tokemon! There are hundreds of Tokemon loose in'),nl,
    sleep(0.5),
    write('Labtek 5! You can catch them all to get stronger, but what I\'m'),nl,
    sleep(0.5),
    write('really interested in are the 2 legendary Tokemons, Icanmon dan'),nl,
    sleep(0.5),
    write('Sangemon. If you can get rid of  all those Tokemon I will'),nl,
    sleep(0.5),
    write('not kill you. Defeat them or capture them, either one works.'),nl,nl,
    sleep(0.5),
    write('Available commands:'),nl,
    write('     start. -- start the game!'),nl,
    write('     help. -- show available commands'),nl,
    write('     quit. -- quit the game'),nl,
    write('     n. s. e. w. -- move'),nl,
    write('     map. -- look at the map'),nl,
    write('     heal -- cure Tokemon in inventory if in gym center'),nl,
    write('     status. -- show your status'),nl,
    write('     save(Filename). -- save your game'),nl, 
    write('     load(Filename). -- load previously saved game'),nl,
    write('     Legends:'),nl,
    write('       - X = Pagar'),nl,
    write('       - G = Gym Center'),nl,
    write('       - P = Player'),nl,
    write('       - L = Legendary'), nl, nl.

initFirst :-
    write('Trainer, I welcome you to Tokemon.'), nl,
    sleep(0.5),
    write('But first, I would like to know your name.'), nl,
    sleep(0.5),
    write('What is your name, Tokemon trainer?'), nl, nl,
    write('Your name: '), read(Username),
    asserta(player(Username)), nl, nl,
    write('Hello, '), write(Username), write('!'), nl, nl,
    sleep(1),
    write('In order to start your Tokemon journey in the wonderful world of Labtek 5,'), nl,
    sleep(0.5),
    write('You need your own Tokemon. Fortunately, I provide Tokemon for new trainers like you.'), nl, nl,
    sleep(0.5),
    write('First, there is bulsabaur, a Grass-type Tokemon that is good against Water- and Electric-'), nl,
    write('type Tokemon.'), nl,
    sleep(1),
    write('Second, there is charamder, a Fire-type Tokemon that does not fear Grass- and Wind-'), nl,
    write('type Tokemon.'), nl,
    sleep(1),
    write('Then there is squirtrel, a Water-type Tokemon for handling Fire- and Earth-type Tokemon.'), nl,
    sleep(1),
    write('After that, there is cupi, an Electric-type Tokemon that is not only cute,'), nl,
    write('but also fierce against Water- and Wind- type Tokemon.'), nl,
    sleep(1),
    write('Next, there is pigday, a Wind-type Tokemon that is a good choice for battling'), nl,
    write('Earth- and Grass- type Tokemon.'), nl,
    sleep(1),
    write('Lastly, we have smackhorny, an Earth-type Tokemon perfect for Electric- and Fire-'), nl,
    write('type Tokemon.'), nl, nl,
    sleep(1),
    repeat,
    write('Which one would you like to choose?'), nl,
    sleep(1),
    write('1. bulsabaur'), nl,
    write('2. charamder'), nl,
    write('3. squirtrel'), nl,
    write('4. cupi'), nl,
    write('5. pigday'), nl,
    write('6. smackhorny'), nl,
    write('Choose the Tokemon that you want by typing its name below.'), nl,
    write('Example: If you want Bulsabaur, type \'bulsabaur\'.'), nl, nl,
    write('Choose your Tokemon: '), read(Tokemonawal), nl,
    tokedex(ID,Tokemonawal,_,_,_,_,_,_),
    (
        ID =:= 1 ->
            write('                                           /'), nl,
            write('                        _,.------....___,.\' \',.-.'), nl,
            write('                     ,-\'          _,.--"        |'), nl,
            write('                   ,\'         _.-\'              .'), nl,
            write('                  /   ,     ,\'                   `'), nl,
            write('                 .   /     /                     ``.'), nl,
            write('                 |  |     .                       \\.\\ '), nl,
            write('       ____      |___._.  |       __               \\ `.'), nl,
            write('     .\'    `---""       ``"-.--"\'`  \\               .  \\ '), nl,
            write('    .  ,            __               `              |   .'), nl,
            write('    `,\'         ,-"\'  .               \\             |    L'), nl,
            write('   ,\'          \'    _.\'                -._          /    |'), nl,
            write('  ,`-.    ,".   `--\'                      >.      ,\'     |'), nl,
            write(' . .\'\'   `-\'       __    ,  ,-.         /  `.__.-      ,\' '), nl,
            write(' ||:, .           ,\'  ;  /  / \\ `        `.    .      .\'/'), nl,
            write(' j|:D  \\          `--\'  \' ,\'_  . .         `.__, \\   , /'), nl,
            write('/ L:_  |                 .  "\' :_;                `.\'.\' '), nl,
            write('.    ""\'                  """""\'                    V'), nl,
            write(' `.                                 .    `.   _,..  `'), nl,
            write('   `,_   .    .                _,-\'/    .. `,\'   __  `'), nl,
            write('    ) \\`._        ___....----"\'  ,\'   .\'  \\ |   \'  \\  .'), nl,
            write('   /   `. "`-.--"\'         _,\' ,\'     `---\' |    `./  |'), nl,
            write('  .   _  `""\'--.._____..--"   ,             \'         |'), nl,
            write('  | ." `. `-.                /-.           /          ,'), nl,
            write('  | `._.\'    `,_            ;  /         ,\'          .'), nl,
            write(' .\'          /| `-.        . ,\'         ,           ,'), nl,
            write(' \'-.__ __ _,\',\'    \'`-..___;-...__   ,.\'\\ ____.___.\' '), nl,
            write(' `"^--\'..\'   \'-`-^-\'"--    `-^-\'`.\'\'"""""`.,^.`.--\' '), nl, nl
            ;
            (
                ID =:= 3 ->
                    write('               _,........__'), nl,
                    write('            ,-\'            "`-.'), nl,
                    write('          ,\'                   `-.'), nl,
                    write('        ,\'                        \\ '), nl,
                    write('      ,\'                           .'), nl,
                    write('      .\'\\               ,"".       `'), nl,
                    write('     ._.\'|             / |  `       \\ '), nl,
                    write('     |   |            `-.\'  ||       `.'), nl,
                    write('     |   |            \'-._,\'||       | \\ '), nl,
                    write('     .`.,\'             `..,\'.\'       , |`-. '), nl,
                    write('     l                       .\'`.  _/  |   `. '), nl,
                    write('     `-.._\'-   ,          _ _\'   -" \\  .     `'), nl,
                    write('`."""""\'-.`-...,---------\',\'         `. `....__.'), nl,
                    write('.\'        `"-..___      __,\'\\          \\  \\     \\ '), nl,
                    write('\\_ .          |   `""""\'    `.           . \\     \\ '), nl,
                    write('  `.          |              `.          |  .     L'), nl,
                    write('    `.        |`--...________.\'.        j   |     |'), nl,
                    write('      `._    .\'      |          `.     .|   ,     |'), nl,
                    write('         `--,\\       .            `7""\' |  ,      |'), nl,
                    write('            ` `      `            /     |  |      |    _,-\'"""`-.'), nl,
                    write('             \\ `.     .          /      |  \'      |  ,\'          `.'), nl,
                    write('              \\  v.__  .        \'       .   \\    /| /              \\ '), nl,
                    write('               \\/    `""\\"""""""`.       \\   \\  /.\'\'                |'), nl,
                    write('                `        .        `._ ___,j.  `/ .-       ,---.     |'), nl,
                    write('                ,`-.      \\         ."     `.  |/        j     `    |'), nl,
                    write('               /    `.     \\       /         \\ /         |     /    j'), nl,
                    write('              |       `-.   7-.._ .          |"          \'         /'), nl,
                    write('              |          `./_    `|          |            .     _,\' '), nl,
                    write('              `.           / `----|          |-............`---\' '), nl,
                    write('                \\          \\      |          |'), nl,
                    write('               ,\'           )     `.         |'), nl,
                    write('                7____,,..--\'      /          |'), nl,
                    write('                                  `---.__,--.\' '), nl, nl
                ;
                    (
                    ID =:= 2 ->
                        write('              _.--""`-..'), nl,
                        write('            ,\'          `.'), nl,
                        write('          ,\'          __  `.'), nl,
                        write('         /|          " __   \\ '), nl,
                        write('        , |           / |.   .'), nl,
                        write('        |,\'          !_.\'|   |'), nl,
                        write('      ,\'             \'   |   |'), nl,
                        write('     /              |`--\'|   |'), nl,
                        write('    |                `---\'   |'), nl,
                        write('     .   ,                   |                       ,".'), nl,
                        write('      ._     \'           _\'  |                    , \' \\ `'), nl,
                        write('  `.. `.`-...___,...---""    |       __,.        ,`"   L,|'), nl,
                        write('  |, `- .`._        _,-,.\'   .  __.-\'-. /        .   ,    \\ '), nl,
                        write('-:..     `. `-..--_.,.<       `"      / `.        `-/ |   .'), nl,
                        write('  `,         """"\'     `.              ,\'         |   |  \',,'), nl,
                        write('    `.      \'            \'            /          \'    |\'. |/'), nl,
                        write('      `.   |              \\       _,-\'           |       \'\' '), nl,
                        write('        `._\'               \\   \'"\\                .      |'), nl,
                        write('           |                \'     \\                `._  ,\' '), nl,
                        write('           |                 \'     \\                 .\'|'), nl,
                        write('           |                 .      \\                | |'), nl,
                        write('           |                 |       L              ,\' |'), nl,
                        write('           `                 |       |             /   \' '), nl,
                        write('            \\                |       |           ,\'   /'), nl,
                        write('          ,\' \\               |  _.._ ,-..___,..-\'    ,\' '), nl,
                        write('         /     .             .      `!             ,j\' '), nl,
                        write('        /       `.          /        .           .\'/ '), nl,
                        write('       .          `.       /         |        _.\'.\' '), nl,
                        write('        `.          7`\'---\'          |------"\'_.\' '), nl,
                        write('       _,.`,_     _\'                ,\'\'-----"\' '), nl,
                        write('   _,-_    \'       `.     .\'      ,\\ '), nl,
                        write('   -" /`.         _,\'     | _  _  _.| '), nl,
                        write('    ""--\'---"""""\'        `\' \'! |! / '), nl,
                        write('                            `" " -\' '), nl, nl
                        ;
                        write(' .----------------. '), nl,
                        write('| .--------------. |'), nl,
                        write('| |    ______    | |'), nl,
                        write('| |   / _ __ `.  | |'), nl,
                        write('| |  |_/____) |  | |'), nl,
                        write('| |    /  ___.\'  | |'), nl,
                        write('| |    |_|       | |'), nl,
                        write('| |    (_)       | |'), nl,
                        write('| |              | |'), nl,
                        write('| \'--------------\' |'), nl,
                        write(' \'----------------\' '), nl, nl
                        )
            )
    ),
    do(ID), nl,
    end_condition(ID),
    status.

end_condition(end).
end_condition(ID) :-
    have(ID), !,
    addTokemon(ID),
    tokedex(ID, TokeName,_,_,_,_,_,_),
    random(15,30,Sizex),
    random(15,30,Sizey),
    initMap(Sizex, Sizey),
    player(Username),
    write('That\'s a good choice!'), nl, nl,
    sleep(1),
    write(Username), write(', I know that you and '),
    write(TokeName), write(' will make great partners!'), nl,
    sleep(0.5),
    write('Before you go, I want to tell you some things.'), nl,
    sleep(0.5),
    write('There is a Tokemon Gym somewhere in this area.'), nl,
    sleep(0.5),
    write('Go there and you can use command \'heal\' to fully heal all your Tokemon.'), nl,
    sleep(0.5),
    write('However, you can only do it once, so do it wisely.'), nl,
    sleep(0.5),
    write('Also, you can only carry 6 Tokemon with you at the same time.'), nl,   
    sleep(0.5),
    write('If you want to capture more Tokemon, you may choose to drop one of your Tokemon.'), nl, nl,
    sleep(1),
    write('With all of that being said, enjoy the adventures of Tokemon!'), nl.

do(X) :- have(X), !.
do(_) :- write('Itu bukan tokemon yang ada di list, cek lagi ya...').
do(end).

have(X) :-
    X =< 6, !.

start :- 
    init(_),
    write('Game sudah dimulai'),!.

start :-
    \+init(_),
    title,
    asserta(init(1)),
    initLegendary(100),
    initLegendary(101),
    initFirst,
    initPlayer,
    generateTembok,
    initLegendaryMap, 
    !.

quit :-
    \+init(_),
    write('Game belum dimulai kok diquit sih WKWK gimana aja'),!.

quit :-
    write('Selamat tinggal! Kamu akan dikenang'), nl,
    retract(positionX(_)),
    retract(positionY(_)),
    retract(lebar(_)),
    retract(panjang(_)),
    retract(tembok(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
    retract(cure(_)),
    forall(inventory(_, _, _, _, _, _, _, _, _, _), (
        retract(inventory(_, _, _, _, _, _, _, _, _, _))
	)),
    forall(legendary(_,_,_,_,_,_,_,_,_), (
        retract(legendary(_,_,_,_,_,_,_,_,_))
    )),
    retract(adaTembok(_)),
    (
        (legendary1(_,_),legendary2(_,_))
        -> retract(legendary1(_,_)),
        retract(legendary2(_,_)),
        retract(player(_)),
        retract(init(_)),
        fail
        ; 
        (legendary1(_,_),\+legendary2(_,_))
        -> retract(legendary1(_,_)), fail
        ;
        (\+legendary1(_,_),legendary2(_,_))
        -> retract(legendary2(_,_)),
        retract(player(_)),
        retract(init(_)),
        fail
        ;
        retract(player(_)),
        retract(init(_))
    ).

/* EKSTERNAL FILE CONFIG */

save(_) :-
	\+init(_),
	write('Command ini hanya bisa dipakai setelah game dimulai.'), nl,
	write('Gunakan command "start." untuk memulai game.'), nl, !.

save(FileName) :-
    player(Username),
        tell(FileName),
            write('player('), write(Username),write(').'),nl,
            writeInventory,
            writeCure,
            writeLebarPanjang,
            writePosisiPlayer,
            writeTembok,
            writeLegendary1,
            writeLegendary2,
        told, !.

writeLebarPanjang :-
    lebar(L),
    panjang(J),
    write('lebar('), write(L), write(').'), nl,
    write('panjang('), write(J), write(').'), nl, !.

writeLegendary1 :-
    legendary1(X,Y),
    write('legendary1('), write(X), write(','), write(Y), write(').'), nl.

writeLegendary1 :-
    \+ legendary1(_,_), !.

writeLegendary2 :-
    legendary2(X,Y),
    write('legendary2('), write(X), write(','), write(Y), write(').'), nl.

writeLegendary2 :-
    \+ legendary2(_,_), !.

writeTembok :-
    tembok(TempX1,TempY1,TempX2,TempY2,TempX3,TempY3,TempX4,TempY4,TempX5,TempY5,TempX6,TempY6,TempX7,TempY7,TempX8,TempY8),
    write('tembok('), write(TempX1), write(','), write(TempY1), write(','), write(TempX2), write(','), write(TempY2), write(','),
    write(TempX3), write(','), write(TempY3), write(','), write(TempX4), write(','), write(TempY4), write(','),
    write(TempX5), write(','), write(TempY5), write(','), write(TempX6), write(','), write(TempY6), write(','),
    write(TempX7), write(','), write(TempY7), write(','), write(TempX8), write(','), write(TempY8), write(').'), nl, !.

writePosisiPlayer :-
    positionX(A),
    positionY(B),
    write('positionX('), write(A), write(').'), nl,
    write('positionY('), write(B), write(').'), nl, !.

writeCure :-
    \+ cure(_), !.

writeCure :-
    write('cure('), write(1), write(').'), nl, !.

writeInventory:-
	\+inventory(_, _, _, _, _, _, _, _, _, _),
	!.

writeInventory:-
	forall(inventory(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special, EXP),(
		write('inventory('), write(ID), write(', '), write(Name), write(', '), write(Type), write(', '),
        write(MaxHealth), write(', '), write(Level), write(', '), write(Health), write(', '), 
        write(Element), write(', '), write(Attack), write(', '), write(Special), write(', '), write(EXP), write(').'), nl
	)), !.

loadGame(_) :-
	init(_),
	write('Kamu tidak bisa memulai game lainnya ketika ada game yang sudah dimulai.'), nl, !.

loadGame(FileName):-
	\+file_exists(FileName),
	write('File tidak ada woi'), nl, write('Tulis ulang atau start game dong.'), nl, !.

loadGame(FileName):-
	open(FileName, read, Stream),
        readFileLines(Stream,Lines),
    close(Stream),
    assertaLine(Lines), 
    asserta(init(1)), !.

assertaLine([]) :- !.

assertaLine([X|L]):-
	asserta(X),
	assertaLine(L), !.

readFileLines(Stream,[]) :-
    at_end_of_stream(Stream).

readFileLines(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    readFileLines(Stream,L).
    readFileLines(Stream,L).