:- dynamic(tokemon/10).      /* Data pokemon di inventory*/
:- dynamic(init/1).          /* Mark game dimulai */
:- dynamic(player/1).

:- include('command.pl').
:- include('leveling.pl').
:- include('player.pl').
:- include('tokedex2.pl').
:- include('battle2.pl').
:- include('map.pl').


title :-
    write(' ____  _____  _  _  ____  __  __  _____  _  _ '),nl,
    write('(_  _)(  _  )( )/ )( ___)(  \\/  )(  _  )( \\( )'),nl,
    write('  )(   )(_)(  )  (  )__)  )    (  )(_)(  )  ( '),nl,
    write(' (__) (_____)(_)\\_)(____)(_/\\/\\_)(_____)(_)\\_)'),nl,nl,
    write('Gotta catch em all!'),nl,
    write('Hello there! Welcome to the world of Tokemon! My name is Aril!'),nl,
    write('People call me the Tokemon Professor! This world is inhabited by'),nl,
    write('creatures called Tokemon! There are hundreds of Tokemon loose in'),nl,
    write('Labtek 5! You can catch them all to get stronger, but what Im'),nl,
    write('really interested in are the 2 legendary Tokemons, Icanmon dan'),nl,
    write('Sangemon. If you can defeat or capture all those Tokemons I will'),nl,
    write('not kill you.'),nl,nl,
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
    write('We welcome you to Tokemon'), nl,
    write('What is your name, Tokemon trainer?'), nl,
    read(Username),
    asserta(player(Username)), nl,
    write('Hello '), write(Username), nl,
    repeat,
    write('Choose your tokemon!'), nl, nl,
    write('1. bulsabaur'), nl, write('Type: grass'), nl, nl,
    write('2. charamder'), nl, write('Type: fire'), nl, nl,
    write('3. squirtrel'), nl, write('Type: water'), nl, nl,
    write('4. cupi'), nl, write('Type: electric'), nl, nl,
    write('5. pigday'), nl, write('Type: wind'), nl, nl,
    write('6. smackhorny'), nl, write('Type: earth'), nl, nl,
    write('Insert tokemon: '),
    read(Tokemonawal), nl,
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
            )
    ),
    do(ID), nl,
    end_condition(ID),
    status.

end_condition(end).
end_condition(X) :- 
    have(X), !,
    addTokemon(X),
    random(15,30,Sizex),
    random(15,30,Sizey),
    initMap(Sizex, Sizey),
    player(Username),
    write('Your information, trainer'), nl,
    write('Username: '), write(Username), nl,nl,
    statusInventory,!.

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
    forall( inventory(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special, EXP), (
        retract(inventory(_, _, _, _, _, _, _, _, _, _))
	)),
    retract(legendary1(_,_)),
    retract(legendary2(_,_)),
    retract(player(_)),
    retract(init(_)).

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
