/*parqueNacional(Nombre).
cerro(Nombre,Altura).
cuerpoDeAgua(cuerpoAgua, Pescar, Temperatura).
cuerpoDeAgua(rio, Pescar, Temperatura).
cuerpoDeAgua(laguna, Pescar, Temperatura).
cuerpoDeAgua(arroyo, Pescar, Temperatura).
playa(DiferenciaDeMarea).
excursion(Nombre).
*/

visitaLugar(Persona, Lugar):-
    vacaciones(Persona, Lugares),
    member(Lugar,Lugares).

persona(Nombre) :- vacaciones(Nombre, _).

vacaciones(dodain, [pehuenia, sanMartin, esquel, sarmiento, camarones, playasDoradas]).
vacaciones(alf, [bariloche, sanMartin, elBolson]).
vacaciones(nico, [marDelPlata]).
vacaciones(vale, [calafate, elBolson]).
vacaciones(martu, Lugares) :-
    vacaciones(alf, Lugares).
vacaciones(martu, Lugares) :-
    vacaciones(nico, Lugares).

atraccionDeLugar(Lugar, Atraccion) :-
    lugar(Lugar, Atracciones),
    member(Atraccion, Atracciones).

lugar(esquel, [parqueNacional(losAlerces), excursion(trochita), excursion(trevelin)]).
lugar(villaPehuenia, [cerro(bateaMuhida,2000), cuerpoDeAgua(sePuedePescar,14), cuerpoDeAgua(sePuedePescar, 19)]).

visitaAtraccion(Persona,Atraccion) :-
    visitaLugar(Persona,Lugar),
    atraccionDeLugar(Lugar, Atraccion).

vacacionCopada(Persona) :-
    visitaAtraccion(Persona,parqueNacional(_)).
vacacionCopada(Persona) :-
    visitaAtraccion(Persona, cerro(_, Metros)),
    Metros > 2000.
vacacionCopada(Persona) :-
    visitaAtraccion(Persona, cuerpoDeAgua(sePuedePescar,_)).
vacacionCopada(Persona) :-
    visitaAtraccion(Persona, cuerpoDeAgua(_, Temperatura)),
    Temperatura > 20.
vacacionCopada(Persona) :-
    visitaAtraccion(Persona, playa(DiferenciaDeMarea)),
    DiferenciaDeMarea < 5.
vacacionCopada(Persona) :-
    visitaAtraccion(Persona, excursion(_)).

seCruzan(Persona1, Persona2,Lugar) :-
    visitaLugar(Persona1, Lugar),
    visitaLugar(Persona2, Lugar),
    Persona1 \= Persona2.

niSeMeCruzoPorLaCabeza(Persona1, Persona2) :-
    persona(Persona1),
    persona(Persona2),
    Persona1 \= Persona2,
    forall(visitaLugar(Persona1, Lugar), not(seCruzan(Persona1, Persona2,Lugar))).

costoDeVida(sarmiento,100).
costoDeVida(esquel,150).
costoDeVida(pehuenia,180).
costoDeVida(sanMartin,150).
costoDeVida(camarones,135).
costoDeVida(playasDoradas,170).
costoDeVida(bariloche,140).
costoDeVida(calafate,240).
costoDeVida(elBolson,145).
costoDeVida(marDelPlata,140).

esGasolero(Lugar) :-
    costoDeVida(Lugar, Costo),
    Costo < 160.

vacacionesGasoleras(Persona) :-
    persona(Persona),
    forall(visitaLugar(Persona,Lugar), esGasolero(Lugar)).

