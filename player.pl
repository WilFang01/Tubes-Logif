:- dynamic(inventory/8).            /* inventory(NamaTokemon) */
:- dynamic(legendary/8).            /* legendary */

maxInventory(6).

cekPanjang(Length) :-
    findall(Name, inventory(Name,_,_,_,_,_,_,_), List),
    length(List,Length).

addTokemon(_,_,_,_,_,_,_,_) :-
    cekPanjang(Length),
    maxInventory(Max),
    Length >= Max,
    write('Sudah Penuh'),
    !,fail.

addTokemon(Name, Type, MaxHealth, Level, Health, Element, Attack, Special) :-
    asserta(inventory(Name, Type, MaxHealth, Level, Health, Element, Attack, Special)),!.

delTokemon(Name, Type, MaxHealth, Level, Health, Element, Attack, Special) :-
    \+inventory(Name, Type, MaxHealth, Level, Health, Element, Attack, Special),
    write('Tidak ada pokemon tersebut di inventory anda'),
    !,fail.

delTokemon(Name, Type, MaxHealth, Level, Health, Element, Attack, Special) :-
    inventory(Name, Type, MaxHealth, Level, Health, Element, Attack, Special),
    retract(inventory(Name, Type, MaxHealth, Level, Health, Element, Attack, Special)),
    !.

initLegendary(Name, Type, MaxHealth, Level, Health, Element, Attack, Special) :-
    asserta(legendary(Name, Type, MaxHealth, Level, Health, Element, Attack, Special)),!.

makeListPokemon(ListNama,ListHealth,ListElement) :-
    findall(Name, inventory(Name,_,_,_,_,_,_,_), ListNama),
    findall(Health, inventory(_,_,_,_,Health,_,_,_), ListHealth),
    findall(Element, inventory(_,_,_,_,_,Element,_,_), ListElement).

makeListLegendary(ListNama,ListHealth,ListElement) :-
    findall(Name, legendary(Name,_,_,_,_,_,_,_), ListNama),
    findall(Health, legendary(_,_,_,_,Health,_,_,_), ListHealth),
    findall(Element, legendary(_,_,_,_,_,Element,_,_), ListElement).

stt([],[],[]).
stt([A|X],[B|Y],[C|Z]) :-
    write(A),nl,
    write('Health: '),
    write(B),nl,
    write('Element: '),
    write(C),nl,nl,
    stt(X,Y,Z).

status :-
    makeListPokemon(ListNama,ListHealth,ListElement),
    write('Your Pokemon'),nl,nl,
    stt(ListNama,ListHealth,ListElement),
    makeListLegendary(NamaLegend,HealthLegend,ElementLegend),
    write('Your Enemy'),nl,nl,
    stt(NamaLegend,HealthLegend,ElementLegend).