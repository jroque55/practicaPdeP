%%%%%%%%%
%Punto 1%
%%%%%%%%%

puestoDeComida(hamburguesa, 2000).
puestoDeComida(panchitosConPapas, 1500).
puestoDeComida(lomitoCompleto, 2500).
puestoDeComida(caramelos, 0).

atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(laCasaEmbrujada, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

atraccion(abismoMortalRecargada, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

atraccion(elTorpedoSalpicon, acuatica).
atraccion(esperoQueHayasTraidoUnaMudadeRopa, acuatica).

visitante(eusebio, datosSuperficiales(80, 3000), animo(50, 0)).
visitante(carmela, datosSuperficiales(80, 0), animo(0, 25)).
visitante(juan, datosSuperficiales(20, 2000), animo(25,25)).
visitante(raul, datosSuperficiales(23, 5000), animo(50,25)).

grupo(viejitos, eusebio).
grupo(viejitos, carmela).

%%%%%%%%%
%Punto 2%
%%%%%%%%%

bienestar(Visitante, felicidadPlena) :-
    visitante(Visitante, _, animo(0,0)).
bienestar(Visitante, podriaEstarMejor) :-
    visitante(Visitante, _, animo(Hambre, Aburrimiento)),
    Suma is Hambre + Aburrimiento,
    between(1,50,Suma).
bienestar(Visitante, necesitaEntretenerse) :-
    visitante(Visitante, _, animo(Hambre, Aburrimiento)),
    Suma is Hambre + Aburrimiento,
    between(50,99,Suma).
bienestar(Visitante, seQuiereIrACasa) :-
    visitante(Visitante, _, animo(Hambre, Aburrimiento)),
    Suma is Hambre + Aburrimiento,
    Suma >= 100.

