:- dynamic(inventory/8).            /* inventory(NamaTokemon) */

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