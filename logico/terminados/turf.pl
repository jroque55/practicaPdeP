jockeys(valdivieso, 155, 52).
jockeys(leguisamo, 161, 49).
jockeys(lezcano, 149, 50).
jockeys(baratucci, 153, 55).
jockeys(falero, 157, 52).

pesoDeJockey(Jockey, Peso) :-
    jockeys(Jockey, _, Peso).

alturaDeJockey(Jockey, Altura):-
    jockeys(Jockey, _, Altura).

caballo(botafogo,baratucci).
caballo(botafogo,Jockey) :-
    pesoDeJockey(Jockey, Peso),
    Peso < 52.

caballo(oldMan,Jockey):-
    jockeys(Jockey,_,_),
    atom_length(Jockey, LongitudDeNombre),
    LongitudDeNombre > 7.

caballo(energica,Jockey) :-
    jockeys(Jockey,_,_),
    not(caballo(botafogo,Jockey)).

caballo(matBoy, Jockey):-
    alturaDeJockey(Jockey, Altura),
    Altura > 170.

%caballeriza(Nombre, Jockey)
caballeriza(elTute, valdivieso).
caballeriza(elTute, falero).
caballeriza(lasHormigas, lezcano).
caballeriza(elcharabon, baratucci).
caballeriza(elcharabon, leguisamo).

stud(elTute).
stud(lasHormigas).
stud(elcharabon).

%premio(Premio, Caballo)
premio(granPremioNacional, botafogo).
premio(granPremioRepublica, botafogo).
premio(granPremioRepublica, oldMan).
premio(campeonatoPalermoDeOro, oldMan).
premio(granPremioCriadores, matBoy).

esPremioImportante(granPremioNacional).
esPremioImportante(granPremioRepublica).

prefiereAMasDeUnJockey(Caballo) :-
    caballo(Caballo, Jockey),
    caballo(Caballo, OtroJockey),
    Jockey \= OtroJockey.

aborrece(botafogo, Stud) :- caballeriza(Stud, Jockey), not(caballo(botafogo,Jockey)).
aborrece(oldMan, lasHormigas).
aborrece(matBoy, Stud):- stud(Stud).

noSeLlamaAmor(Caballo):-
    aborrece(Caballo,_).

montaCaballoConPremio(Caballo, Jockey, Premio):-
    caballo(Caballo, Jockey),
    premio(Premio, Caballo).

caballosConPremioImportante(Caballo, Premio):-
    premio(Premio, Caballo),
    esPremioImportante(Premio).

piolines(Jockey) :-
    jockeys(Jockey,_,_),
    forall(caballosConPremioImportante(Caballo,_), caballo(Caballo, Jockey)).


salePrimero(Caballo, Resultados):-
    nth1(Caballo, 1, Resultados).
saleSegundo(Caballo, Resultados):-
    nth1(Caballo, 2, Resultados).

salePrimeroOSegundo(Caballo, Resultados):-
    salePrimero(Caballo,Resultados).
salePrimeroOSegundo(Caballo, Resultados):-
    saleSegundo(Caballo, Resultados).

apuestaGanadora(aGanador(Caballo), Resultados):-
    salePrimero(Caballo, Resultados).

apuestaGanadora(aSegundo(Caballo), Resultados):-
    salePrimeroOSegundo(Caballo, Resultados).

apuestaGanadora(exacta(Caballo, OtroCaballo), Resultados):-
    salePrimero(Caballo, Resultados),
    saleSegundo(OtroCaballo, Resultados).

apuestaGanadora(imperfecta(Caballo, OtroCaballo), Resultados):-
    salePrimeroOSegundo(Caballo, Resultados),
    salePrimeroOSegundo(OtroCaballo, Resultados).

colorDeCrin([negro], botafogo).
colorDeCrin([marron], oldMan).
colorDeCrin([gris, negro], energica).
colorDeCrin([marron, blanco], matBoy).
colorDeCrin([blanco, marron], yatasto).

esColorDeCrin(Caballo, Color):-
    colorDeCrin(Colores, Caballo),
    member(Color, Colores).
    
