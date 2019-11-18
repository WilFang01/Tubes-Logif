:- dynamic(inventory/10).            /* inventory(NamaTokemon) */
:- dynamic(legendary/9).            /* legendary */

maxInventory(6).

cekPanjang(Length) :-
    findall(Name, inventory(_,Name,_,_,_,_,_,_,_,_), List),
    length(List,Length).    

isFull :-
    cekPanjang(Length),
    Length == 6.

addTokemon(_) :-
    cekPanjang(Length),
    maxInventory(Max),
    Length >= Max,
    write('Sudah Penuh.'),
    !,fail.

addTokemon(ID) :-
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,
    Exp is 0,
    asserta(inventory(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special, Exp)),!.

delTokemon(ID) :-
    \+inventory(ID,_,_,_,_,_,_,_,_,_),
    write('Tidak ada Tokemon tersebut di inventorymu.'),
    !,fail.

delTokemon(ID) :-
    retract(inventory(ID,_,_,_,_,_,_,_,_,_)),
    !.

initLegendary(ID) :-
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,
    asserta(legendary(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special)),!.

makeListPokemon(ListNama,ListHealth,ListElement,ListLevel) :-
    findall(Name, inventory(_,Name,_,_,_,_,_,_,_,_), ListNama),
    findall(Health, inventory(_,_,_,_,_,Health,_,_,_,_), ListHealth),
    findall(Element, inventory(_,_,_,_,_,_,Element,_,_,_), ListElement),
    findall(Level, inventory(_,_,_,_,Level,_,_,_,_,_), ListLevel).

makeListLegendary(ListNama,ListHealth,ListElement,ListLevel) :-
    findall(Name, legendary(_,Name,_,_,_,_,_,_,_), ListNama),
    findall(Health, legendary(_,_,_,_,_,Health,_,_,_), ListHealth),
    findall(Element, legendary(_,_,_,_,_,_,Element,_,_), ListElement),
    findall(Level, legendary(_,_,_,_,Level,_,_,_,_), ListLevel).

stt([],[],[],[]).
stt([A|X],[B|Y],[C|Z],[D|W]) :-
    write(A),nl,
    write('Health: '),
    write(B),nl,
    write('Element: '),
    write(C),nl,
    write('Level: '),
    write(D),nl,nl,
    stt(X,Y,Z,W).

status :-
    init(_),
    player(Username), nl,
    write('Your name is '), write(Username), write('.'), nl, nl,
    makeListPokemon(ListNama,ListHealth,ListElement,ListLevel),
    write('Your Tokemon:'),nl,nl,
    stt(ListNama,ListHealth,ListElement,ListLevel),
    makeListLegendary(NamaLegend,HealthLegend,ElementLegend,LevelLegend),
    write('Your Final Enemy:'),nl,nl,
    stt(NamaLegend,HealthLegend,ElementLegend,LevelLegend).

statusInventory :-
    init(_),
    makeListPokemon(ListNama,ListHealth,ListElement,ListLevel),
    write('Your Tokemon:'),nl,nl,
    stt(ListNama,ListHealth,ListElement,ListLevel).