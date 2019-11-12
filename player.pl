:- dynamic(inventory/10).            /* inventory(NamaTokemon) */
:- dynamic(legendary/9).            /* legendary */

:- include('tokedex.pl').

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
    write('Sudah Penuh'),
    !,fail.

addTokemon(ID) :-
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,
    Exp is 0,
    asserta(inventory(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special, Exp)),!.

delTokemon(ID) :-
    \+inventory(ID,_,_,_,_,_,_,_,_,_),
    write('Tidak ada pokemon tersebut di inventory anda'),
    !,fail.

delTokemon(ID) :-
    retract(inventory(ID,_,_,_,_,_,_,_,_,_)),
    !.

initLegendary(ID) :-
    tokedex(ID, Name, Type, MaxHealth, Level, Element, Attack, Special),
    Health is MaxHealth,
    asserta(legendary(ID, Name, Type, MaxHealth, Level, Health, Element, Attack, Special)),!.

makeListPokemon(ListNama,ListHealth,ListElement) :-
    findall(Name, inventory(_,Name,_,_,_,_,_,_,_,_), ListNama),
    findall(Health, inventory(_,_,_,_,_,Health,_,_,_,_), ListHealth),
    findall(Element, inventory(_,_,_,_,_,_,Element,_,_,_), ListElement).

makeListLegendary(ListNama,ListHealth,ListElement) :-
    findall(Name, legendary(_,Name,_,_,_,_,_,_,_), ListNama),
    findall(Health, legendary(_,_,_,_,_,Health,_,_,_), ListHealth),
    findall(Element, legendary(_,_,_,_,_,_,Element,_,_), ListElement).

stt([],[],[]).
stt([A|X],[B|Y],[C|Z]) :-
    write(A),nl,
    write('Health: '),
    write(B),nl,
    write('Element: '),
    write(C),nl,nl,
    stt(X,Y,Z).

status :-
    init(_),
    makeListPokemon(ListNama,ListHealth,ListElement),
    write('Your Pokemon'),nl,nl,
    stt(ListNama,ListHealth,ListElement),
    makeListLegendary(NamaLegend,HealthLegend,ElementLegend),
    write('Your Enemy'),nl,nl,
    stt(NamaLegend,HealthLegend,ElementLegend).

statusInventory :-
    init(_),
    makeListPokemon(ListNama,ListHealth,ListElement),
    write('Your Pokemon:'),nl,nl,
    stt(ListNama,ListHealth,ListElement).