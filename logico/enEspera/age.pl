% …jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% …tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).
tiene(juan, edificio(casa, 40)).

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).

ratingJugador(Nombre, Rating) :-
    jugador(Nombre, Rating, _).

esUnAfano(Jugador1, Jugador2) :-
    ratingJugador(Jugador1, Rating1),
    ratingJugador(Jugador2, Rating2),
    DiferenciaDeRating is Rating1 - Rating2,
    DiferenciaDeRating > 500.

esMilitar(Tipo, Costo, Categoria) :-
    militar(Tipo,Costo, Categoria).

ganaPorCategoria(caballeria, arqueria).
ganaPorCategoria(arqueria, infanteria).
ganaPorCategoria(infanteria, piquero).
ganaPorCategoria(piquero, caballeria).

esEfectivo(samurai, Unidad2) :-
    esMilitar(Unidad2,_,unico).

esEfectivo(Unidad1, Unidad2) :-
    esMilitar(Unidad1, _, Categoria1),
    esMilitar(Unidad2, _, Categoria2),
    ganaPorCategoria(Categoria1, Categoria2).

soloTieneDeCategoria(Jugador, Categoria) :-
    tiene(Jugador,_),
    forall(tiene(Jugador, unidad(Tipo,_)), esMilitar(Tipo,_, Categoria)).

esAlarico(Jugador) :-
    soloTieneDeCategoria(Jugador, infanteria).

esLeonidas(Jugador) :-
    soloTieneDeCategoria(Jugador, piquero).

esNomada(Jugador) :-
    jugador(Jugador,_,_),
    not(tiene(Jugador, edificio(casa,_))).

cuantoCuesta(Unidad, Costo) :-
    militar(Unidad, Costo, _).
cuantoCuesta(Edificio, Costo) :-
    edificio(Edificio, Costo).
cuantoCuesta(carreta, costo(100, 0, 50)).
cuantoCuesta(urnaMercante, costo(100, 0, 50)).
cuantoCuesta(Aldeano, costo(0,50,0)) :-
    aldeano(Aldeano,_).

esAldeano(Unidad, ProduccionPorMinuto) :-
    aldeano(Unidad, ProduccionPorMinuto).

produccion(Unidad, Produccion) :-
    esAldeano(Unidad, Produccion).
produccion(carreta, producccion(0,0,32)).
produccion(urnaMercante, produccion(0,0,32)).
produccion(keshik, produccion(0,0,10)) :-
    esMilitar(keshik,_,_).

recurso(madera).
recurso(alimento).
recurso(oro).

produccionDelRecurso(madera, produccion(Madera,_,_), Madera).
produccionDelRecurso(alimento, produccion(_,Alimento,_), Alimento).
produccionDelRecurso(oro, produccion(_,_,Oro), Oro).


loTieneYProduce(Jugador, Recurso, ProduccionTotal) :-
    tiene(Jugador, unidad(Unidad, CantidadDeUnidades)),
    produccion(Unidad, Produccion),
    produccionDelRecurso(Recurso, Produccion, CantidadDeRecurso),
    ProduccionTotal is CantidadDeRecurso * CantidadDeUnidades.

produccionTotal(Jugador, ProduccionTotal, Recurso) :-
    tiene(Jugador,_),
    recurso(Recurso),
    findall(Produccion, loTieneYProduce(Jugador, Recurso, Produccion), ListaDeProducciones),
    sum_list(ListaDeProducciones, ProduccionTotal).
    
