%vocaloid(Nombre, cancion(Nombre, Duracion)).

vocaloid(megurineLuka, cancion(nightFever, 4)).
vocaloid(megurineLuka, cancion(foreverYoung, 4)).
vocaloid(hatsuneMiku, cancion(tellYourWorld, 4)).
vocaloid(gumi, cancion(foreverYoung, 4)).
vocaloid(seeU, cancion(novemberRain,6)).
vocaloid(seeU, cancion(nightFever,5)).
vocaloid(seeU, cancion(elRito,5)).

cantante(Nombre) :-
    vocaloid(Nombre, _).

%%%%%%%%%%%
%%Punto 1%%
%%%%%%%%%%%

cancionesEnRepertorio(Vocaloid, TotalCanciones) :-
    findall(Cancion, puedeCantar(Vocaloid, Cancion,_), Canciones),
    length(Canciones, TotalCanciones).

puedeCantar(Vocaloid, Cancion, Duracion) :-
    vocaloid(Vocaloid, cancion(Cancion, Duracion)).

duracionRepertorio(Vocaloid, Duracion) :-
    findall(Minutos , puedeCantar(Vocaloid, _, Minutos), MinutosTotales),
    sum_list(MinutosTotales, Duracion).
    
vocaloidNovedoso(Vocaloid) :-
    cantante(Vocaloid),
    cancionesEnRepertorio(Vocaloid,TotalCanciones),
    TotalCanciones >= 1,
    duracionRepertorio(Vocaloid, Duracion),
    Duracion >= 15.

%%%%%%%%%%%
%%Punto 2%%
%%%%%%%%%%%

esAcelerado(Vocaloid) :-
    vocaloid(Vocaloid, _),
    not((puedeCantar(Vocaloid, _, Duracion), Duracion > 4)).

%concierto(Nombre, CancionesQueConoceElCantante, DuracionMinimaDeCadaCancion).
%mediano(DuracionTotalDeLasCanciones < x)
%pequeno(DuracionDeAlmenosUnaCancion > x)

concierto(mikuExpo, gigante(2, 6), 2000).
concierto(magicalMirai, gigante(3, 10), 3000).
concierto(vocalektVisions, mediano(9), 1000).
concierto(mikuFest, pequeno(4), 100).

cumpleRequisitosDelConcierto(Concierto, Vocaloid) :-
    concierto(Concierto, gigante(CancionesConocidas, DuracionMinima), _),
    cancionesEnRepertorio(Vocaloid, TotalCanciones),
    TotalCanciones > CancionesConocidas,
    duracionRepertorio(Vocaloid, Duracion),
    Duracion > DuracionMinima.

cumpleRequisitosDelConcierto(Concierto, Vocaloid) :-
    concierto(Concierto, mediano(DuracionTotal), _),
    duracionRepertorio(Vocaloid, DuracionRepertorio),
    DuracionRepertorio < DuracionTotal.

cumpleRequisitosDelConcierto(Concierto, Vocaloid) :-
    concierto(Concierto, pequeno(DuracionMinima), _),
    puedeCantar(Vocaloid, _, Duracion),
    Duracion > DuracionMinima.

puedeParticiparEnConcierto(Concierto, hatsuneMiku) :- concierto(Concierto,_,_).
puedeParticiparEnConcierto(Concierto, Vocaloid) :-
    cantante(Vocaloid),
    Vocaloid \= hatsuneMiku,
    cumpleRequisitosDelConcierto(Concierto, Vocaloid).

famaDelConcierto(Concierto, Fama) :-
    concierto(Concierto, _, Fama).

famaGanada(Vocaloid , FamaObtenida) :-
    puedeParticiparEnConcierto(Concierto, Vocaloid),
    famaDelConcierto(Concierto, FamaObtenida).

famaTotalPorConciertos(Vocaloid, FamaTotal) :-
    cantante(Vocaloid),
    findall(Fama, famaGanada(Vocaloid, Fama), FamaObtenida),
    sum_list(FamaObtenida, FamaTotal).

famaTotal(Vocaloid, FamaTotal) :-
    famaTotalPorConciertos(Vocaloid, Fama),
    cancionesEnRepertorio(Vocaloid, CantidadCanciones),
    FamaTotal is Fama * CantidadCanciones.

vocaloidMasFamoso(Vocaloid) :-
    famaTotal(Vocaloid, FamaTotal),
    forall(famaTotal(_, Fama), FamaTotal >= Fama).

conoceA(megurineLuka, hatsuneMiku).
conoceA(megurineLuka, gumi).
conoceA(gumi, seeU).
conoceA(seeU, kaito).

seConocen(Vocaloid1, Vocaloid2) :- conoceA(Vocaloid1, Vocaloid2).

seConocen(Vocaloid, OtroVocaloid) :-
    conoceA(Vocaloid, UnVocaloid),
    conoceA(UnVocaloid, OtroVocaloid).

unicoParticipante(Vocaloid, Concierto) :-
    puedeParticiparEnConcierto(Vocaloid, Concierto),
    not(seConocen(Vocaloid, OtroVocaloid)),
    puedeParticiparEnConcierto(OtroVocaloid, Concierto),
    Vocaloid \= OtroVocaloid.

