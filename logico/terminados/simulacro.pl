%juegos(Nombre, genero(), precio)

juego(accion(eldenRing), 4000).
juego(rol(metin2, 1000), 500).
juego(puzzle(escapeRoom, 10, media), 1000).
juego(accion(minecraft), 2000).

%estaEnOferta(Nombre, Porcentaje).

estaEnOferta(eldenRing, 50).
estaEnOferta(outlast, 25).
estaEnOferta(minecraft, 50).
    
%TODO: Reemplazar usando polimorfismo, no me acuerdo muy bien ahora

nombreJuego(Nombre, Precio) :- juego(accion(Nombre), Precio).
nombreJuego(Nombre, Precio) :- juego(rol(Nombre,_), Precio).
nombreJuego(Nombre, Precio) :- juego(puzzle(Nombre,_,_), Precio).

precioDeJuego(Nombre, Precio) :-
    estaEnOferta(Nombre,Descuento),
    nombreJuego(Nombre,PrecioActual),
    Precio is (Descuento/100) * PrecioActual.

precioDeJuego(Nombre,Precio) :-
    nombreJuego(Nombre, Precio),
    not(estaEnOferta(Nombre,_)).

tieneBuenDescuento(Juego) :-
    estaEnOferta(Juego, Descuento),
    Descuento >= 50.

esPopular(Nombre) :- juego(accion(Nombre), _).
esPopular(Nombre) :- juego(rol(Nombre, CantidadDeJugadores), _) , CantidadDeJugadores > 1000000.
esPopular(Nombre) :- juego(puzzle(Nombre,_, facil), _).
esPopular(Nombre) :- juego(puzzle(Nombre,25,_), _).
esPopular(minecraft).
esPopular(counterStrike).

%jugador(Usuario, propio(JuegoEnBiblioteca)).
%jugador(Usuario, futuro(Juego, ParaQuien))

jugador(jotade, propio(eldenRing)).
jugador(jotade, futuro(eldenRing, jotade)).
jugador(jotade, futuro(minecraft, jotade)).
jugador(benito, futuro(darkSouls2, jotade)).
jugador(juli, futuro(escapeRoom, benito)).
jugador(benito, futuro(terraria, juli)).

%Juegos que tiene pensado comprar un jugador
juegosFuturos(Jugador, Juego) :-
    jugador(Jugador, futuro(Juego,_)).

juegoParaRegalo(Jugador, ParaQuien, Juego) :-
    jugador(Jugador, futuro(Juego, ParaQuien)),
    Jugador \= ParaQuien.

adictoAlosDescuento(Jugador) :-
    jugador(Jugador,_),
    forall(juegosFuturos(Jugador, Juego), tieneBuenDescuento(Juego)).

generoJuego(Juego, accion) :-
    juego(accion(Juego),_).

generoJuego(Juego, puzzle) :-
    juego(puzzle(Juego,_,_),_).

generoJuego(Juego, rol) :-
    juego(rol(Juego,_),_).

generoDelJuegoQuePosee(Jugador, Juego, Genero) :-
    jugador(Jugador, propio(Juego)),
    generoJuego(Juego, Genero).

esFanaticoDeUnGenero(Jugador) :-
    generoDelJuegoQuePosee(Jugador,Juego1, Genero),
    generoDelJuegoQuePosee(Jugador, Juego2, Genero),
    Juego1 \= Juego2.

monotematico(Jugador) :-
    generoDelJuegoQuePosee(Jugador, Juego, Genero1), 
    not((generoDelJuegoQuePosee(Jugador, Juego, Genero2), Genero1 \= Genero2)).

sonBuenosAmigos(Jugador1, Jugador2) :-
    juegoParaRegalo(Jugador1, Jugador2, Juego1),
    juegoParaRegalo(Jugador2, Jugador1, Juego2),
    esPopular(Juego1),
    esPopular(Juego2).

precioJuegoFuturo(Jugador, Juego, Precio) :-
    juegosFuturos(Jugador, Juego),
    precioDeJuego(Juego, Precio).

cuantoGastara(Jugador, AGastar) :-
    findall(Precio, precioJuegoFuturo(Jugador, _, Precio), Carrito),
    sum_list(Carrito, AGastar).
    