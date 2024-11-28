turnos(dodain, [lunes,miercoles, viernes], horario(9,15)).
turnos(lucas, [martes], horario(10,20)).
turnos(juanC, [sabado, domingo], horario(18,22)).
turnos(juanFdS, [jueves], horario(10,20)).
turnos(juanFdS, [viernes], horario(12,20)).
turnos(leoC, [lunes,miercoles], horario(14,18)).
turnos(martu, [miercoles], horario(23,24)).
turnos(vale, Dias, Horario) :-
    turnos(juanC, Dias, Horario).
turnos(vale, Dias, Horario) :-
    turnos(dodain, Dias, Horario).

%persona(Persona) :- turnos(Persona,_,_).

horaQueAtiende(Persona, Hora) :-
    turnos(Persona,_, horario(Desde, Hasta)),
    Hora >= Desde,
    Hasta >= Hora.

diaQueAtiende(Persona, Dia) :-
    turnos(Persona, Dias,_),
    member(Dia, Dias).

quienAtiende(Persona, Dia, Hora) :-
    diaQueAtiende(Persona, Dia),
    horaQueAtiende(Persona, Hora).

foreverAlone(Persona, Dia, Hora) :-
    quienAtiende(Persona,Dia,Hora),
    not((quienAtiende(Persona2,Dia,Hora), Persona \= Persona2)).

/*posibilidadDeAtencion(Dia, Atienden) :-
    findall(_, quienAtiende(_,Dia,_), Atienden).
*/

ventas(dodain, lunes, [golosinas(1200), 
    cigarrillos(jockey), golosinas(50)]).
ventas(dodain,miercoles, [bebidas(alcoholica, 8), 
    bebidas(noAlcoholica,1), golosinas(10)]).
ventas(martu, miercoles, [golosinas(1000), 
    cigarrillos(chesterfield),cigarrillos(colorado), 
    cigarrillos(parisiennes)]).
ventas(lucas, martes, [golosinas(600)]).
ventas(lucas, martes, [bebidas(noAlcoholica,2),
    cigarrillos(derby)]).

diaQueVendio(Persona, Dia) :-
    ventas(Persona, Dia, _).

queVendio(Persona, Venta) :-
    ventas(Persona, _, Ventas),
    member(Venta, Ventas).

vendedorSuertudo(Persona) :-
    queVendio(Persona, golosinas(Valor)),
    Valor > 100.
vendedorSuertudo(Persona) :-
    findall(_, queVendio(Persona, cigarrillos(_)), Cigarrillos),
    length(Cigarrillos, Cantidad),
    Cantidad > 2.
vendedorSuertudo(Persona) :-
    queVendio(Persona, bebidas(alcoholica,_)).
vendedorSuertudo(Persona) :-
    queVendio(Persona, bebidas(_, Cantidad)),
    Cantidad > 5.