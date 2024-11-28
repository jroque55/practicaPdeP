% Relaciona Pirata con Tripulacion
tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).
tripulante(law, heart).
tripulante(bepo, heart).
tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% Relaciona Pirata, Evento y Monto
impactoEnRecompensa(luffy,arlongPark, 30000000).
impactoEnRecompensa(luffy,baroqueWorks, 70000000).
impactoEnRecompensa(luffy,eniesLobby, 200000000).
impactoEnRecompensa(luffy,marineford, 100000000).
impactoEnRecompensa(luffy,dressrosa, 100000000).
impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).
impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).
impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).
impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).
impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).
impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo, 240000000).
impactoEnRecompensa(law, dressrosa, 60000000).
impactoEnRecompensa(bepo,sabaody,500).
impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).

participaEnEvento(Pirata, Evento) :-
    impactoEnRecompensa(Pirata, Evento, _).

tripulacionEnEvento(Tripulacion, Evento) :-
    tripulante(Pirata, Tripulacion),
    impactoEnRecompensa(Pirata, Evento, _).

participaronDelMismoEvento(Tripulacion1, Tripulacion2, Evento) :-
    tripulacionEnEvento(Tripulacion1, Evento),
    tripulacionEnEvento(Tripulacion2, Evento),
    Tripulacion1 \= Tripulacion2.

destacoEnUnEvento(Evento, Pirata) :-
    impactoEnRecompensa(Pirata, Evento, Recompensa1),
    forall(impactoEnRecompensa(_, Evento, Recompensa2), Recompensa1 >= Recompensa2).

pasoDesapercibido(Pirata, Evento) :-
    tripulante(Pirata, Tripulacion),
    tripulacionEnEvento(Tripulacion, Evento),
    not(impactoEnRecompensa(Pirata, Evento, _)).
    
recompensaActual(Pirata, Tripulacion,RecompensaTotal) :-
    tripulante(Pirata, Tripulacion),
    findall(Recompensa ,impactoEnRecompensa(Pirata, _, Recompensa),MontosObtenidos),
    sum_list(MontosObtenidos, RecompensaTotal).
    
recompensaDeTripulacion(Tripulacion, RecompensaTotal) :-
    tripulacionEnEvento(Tripulacion,_),
    findall(RecompensasDeTripulantes, recompensaActual(_, Tripulacion, RecompensasDeTripulantes), ListaConRecompensas),
    sum_list(ListaConRecompensas, RecompensaTotal).



tripulacionTemible(Tripulacion) :-
    tripulante(_, Tripulacion),
    forall(tripulante(Pirata,Tripulacion), esPeligroso(Pirata)).

tripulacionTemible(Tripulacion) :-
    tripulante(_, Tripulacion),
    recompensaDeTripulacion(Tripulacion, Recompensa),
    Recompensa > 500000000.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

frutaPeligrosa(paramecia(opeope)).

frutaPeligrosa(logia(_)).

frutaPeligrosa(zoan(_, Especie)) :-
    zoanFeroz(zoan(_, Especie)).

zoanFeroz(zoan(_, lobo)).
zoanFeroz(zoan(_, leopardo)).
zoanFeroz(zoan(_, anaconda)).

comioFruta(luffy, paramecia(gomugomu)).
comioFruta(buggy, paramecia(barabara)).
comioFruta(law, paramecia(opeope)).
comioFruta(chopper, zoan(hitohito, humano)).
comioFruta(lucci, zoan(nekoneko, leopardo)).
comioFruta(smoker, logia(mokumoku)).

puedeNadar(Pirata) :-
    not(comioFruta(Pirata,_)).

esPeligroso(Pirata) :-
    comioFruta(Pirata, Fruta),
    frutaPeligrosa(Fruta).

esPeligroso(Pirata) :- 
    recompensaActual(Pirata, _, Recompensa), 
    Recompensa >= 100000000.

tripulacionDeAsfalto(Tripulacion) :-
    tripulante(_, Tripulacion),
    not((tripulante(Pirata,Tripulacion), puedeNadar(Pirata))).