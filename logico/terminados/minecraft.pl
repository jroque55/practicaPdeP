jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra,
piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon,
carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta,
panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

%%%%%%%%%%%
%%PUNTO 1%%
%%%%%%%%%%%

jugadoresEnLugar(Lugar, Jugadores) :-
    lugar(Lugar, EnLugar,_),
    length(EnLugar, Jugadores).

tieneItem(Jugador, Item) :-
    jugador(Jugador, Items,_),
    member(Item, Items).

tieneComida(Jugador, Item) :-
    tieneItem(Jugador,Item),
    comestible(Item).

sePreocupaPorSuSalud(Jugador) :-
    tieneComida(Jugador, Comestible1),
    tieneComida(Jugador, Comestible2),
    Comestible1 \= Comestible2.

cantidadDeItem(Item, Jugador, Cantidad) :-
    tieneItem(_,Item),
    findall(Item, tieneItem(Jugador, Item), ListaDeItem),
    length(ListaDeItem, Cantidad).

tieneMasDe(Jugador, Item) :-
    jugador(Jugador,_,_),
    cantidadDeItem(Item, Jugador, Cantidad),
    forall(cantidadDeItem(Item, _, CantidadDeOtros), Cantidad >= CantidadDeOtros).

nivelDeOscuridad(Lugar,Nivel) :-
    lugar(Lugar,_,Nivel).

hayMonstruos(Lugar):-
    nivelDeOscuridad(Lugar, Nivel),
    Nivel > 6.

dondeEstaJugador(Jugador,Lugar) :-
    lugar(Lugar, Jugadores, _),
    member(Jugador, Jugadores).

hambreJugador(Jugador, Hambre) :-
    jugador(Jugador, _, Hambre).

tieneHambre(Jugador) :-
    hambreJugador(Jugador, Hambre),
    Hambre < 4.

correPeligro(Jugador) :-
    dondeEstaJugador(Jugador, Lugar),
    hayMonstruos(Lugar).

correPeligro(Jugador) :-
    tieneHambre(Jugador),
    not(tieneComida(Jugador, _)).

hambrientosEnLugar(Lugar, Hambrientos) :-
    findall(Jugador, (tieneHambre(Jugador), dondeEstaJugador(Jugador, Lugar)), Jugadores),
    length(Jugadores, Hambrientos).

nivelDePeligrosidad(Lugar, 100) :-
    lugar(Lugar,_,_),
    hayMonstruos(Lugar).

nivelDePeligrosidad(Lugar, Nivel) :-
    not(dondeEstaJugador(_,Lugar)),
    nivelDeOscuridad(Lugar,Oscuridad),
    Nivel is Oscuridad * 10.

nivelDePeligrosidad(Lugar, Peligrosidad) :-
    not(hayMonstruos(Lugar)),
    hambrientosEnLugar(Lugar, Hambrientos),
    jugadoresEnLugar(Lugar, Jugadores),
    Peligrosidad is (Hambrientos / Jugadores) *100.

item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

puedeConstruir(Item, Jugador) :-
    jugador(Jugador,_,_),
    item(Item,_),
    forall(componenteItem(Item, Componente), puedeCraftear(Jugador,Componente)).

componenteItem(Item, Componente) :-
    item(Item, Componentes),
    member(Componente, Componentes).

puedeCraftear(Jugador, itemSimple(Componente, Cantidad)) :-
    tieneItem(Jugador, Componente),
    cantidadDeItem(Componente, Jugador, CantidadComponente),
    CantidadComponente >= Cantidad.

puedeCraftear(Jugador, itemCompuesto(Item)) :-
    puedeConstruir(Item, Jugador).