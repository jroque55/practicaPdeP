%ingresante(nombre, tipoDeSangre, caracteristicas, casaQueOdia).
mago(harry, mestiza, [coraje, amistoso, orgulloso, inteligencia], slytherin).
mago(draco, pura, [inteligencia, orgulloso,amistoso,coraje], hufflepuff).
mago(hermione, impura, [inteligencia, orgulloso, responsabilidad], ninguna).

casa(gryffindor, [coraje]).
casa(slytherin, [orgulloso, inteligencia]).
casa(ravenclaw, [inteligencia, responsabilidad]).
casa(hufflepuff, [amistoso]).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

%%%%%%%%%%%
%%Punto 1%%
%%%%%%%%%%%

permiteEntrar(Casa, Mago) :-
    mago(Mago, _, _, _),
    casa(Casa,_),
    Casa \= slytherin.

permiteEntrar(slytherin, Mago) :-
    mago(Mago, Sangre, _, _),
    Sangre \= impura.

%%%%%%%%%%%
%%Punto 2%%
%%%%%%%%%%%

tieneCaracterApropiado(Mago, Casa) :-
    mago(Mago, _, Caracter, _),
    casa(Casa, Requisitos),
    intersection(Requisitos, Caracter, Requisitos).

%%%%%%%%%%%
%%Punto 3%%
%%%%%%%%%%%

dondePuedeQuedarMago(Mago, Casa) :-
    mago(Mago, _, _, Odiaria),
    casa(Casa, _),
    permiteEntrar(Casa,Mago),
    tieneCaracterApropiado(Mago, Casa),
    Odiaria \= Casa.
        
%%%%%%%%%%%
%%Punto 4%%
%%%%%%%%%%%

esAmistoso(Mago) :-
    mago(Mago,_,Caracter,_),
    member(amistoso,Caracter).

cadenaDeAmistades(Magos) :-
    forall((member(Mago,Magos)), esAmistoso(Mago)),
    cadenaDeCasas(Magos).

cadenaDeCasas([Mago1, Mago2 | Magos]) :-
    dondePuedeQuedarMago(Mago1, Casa),
    dondePuedeQuedarMago(Mago2, Casa),
    cadenaDeCasas([Mago2 | Magos]).
cadenaDeCasas([_]).
cadenaDeCasas([]).
            
%%%%%%%%%%%
%%Punto 5%%
%%%%%%%%%%%

acciones(irAlBosque, mala, 50).
acciones(irAlTercerPiso, mala, 75).
acciones(irABiblioteca, mala, 10).
acciones(ganarEnAjedrez, buena, 50).
acciones(usarIntelectoParaSalvar, buena, 50).
acciones(ganarleAVoldemort, buena, 60).

accionesRealizadas(harry, andarFueraDeCama).
accionesRealizadas(hermione, irAlTercerPiso).
accionesRealizadas(hermione, irABiblioteca).
accionesRealizadas(harry, irAlBosque).
accionesRealizadas(harry, irAlTercerPiso).
accionesRealizadas(draco, irAMazmorras).
accionesRealizadas(ron, ganarEnAjedrez).
accionesRealizadas(hermione, usarIntelectoParaSalvar).
accionesRealizadas(harry, ganarleAVoldemort).

esBuenaAccion(Accion) :-
    acciones(Accion,Calificacion,_),
    Calificacion = buena.

esBuenAlumno(Mago) :-
    accionesRealizadas(Mago, Accion),
    esBuenaAccion(Accion).

actividadRecurrente(acciones(_, _, _)) :-
