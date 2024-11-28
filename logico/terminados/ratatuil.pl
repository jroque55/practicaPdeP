% NombreRata, donde viven
rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

%NombreCocinero, plato, experiencia con el plato
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).
cocina(amelie, ratatouille, 8).

%donde trabajan, NombreCocinero
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

% % % % %
%Punto 1%
% % % % %

%restaurantes que existen
restaurante(Lugar) :-
    rata(_, Lugar).

restaurante(Lugar) :-
    trabajaEn(Lugar,_).

%no viven ratas, en el restaurante
inspeccionSatisfactoria(Lugar) :-
    restaurante(Lugar),
    not(rata(_,Lugar)).

% % % % %
%Punto 2%
% % % % %

cocinaAlgunPlato(Empleado, Plato) :- cocina(Empleado, Plato, _).

%relaciona un empleado, con un restaurante si este trabaja ahi y sabe hacer un plato 
chef(Empleado, Restaurante) :-
    trabajaEn(Restaurante, Empleado),
    cocinaAlgunPlato(Empleado, _).

% % % % %
%Punto 3%
% % % % %

%Relaciona a una rata si vive donde trabaja linguini
chefcito(Rata) :-
    rata(Rata, Restaurante),
    trabajaEn(Restaurante, linguini).

% % % % %
%Punto 4%
% % % % %

%Si una persona, tiene experiencia mayor a 7 cocinando un plato
cocinaBien(Persona, Plato) :-
    cocina(Persona, Plato, Experiencia),
    Experiencia > 7.

%remy cocina bien cualquier plato que exista
cocinaBien(remy, Plato) :-
    cocina(_, Plato,_).

% % % % %
%Punto 5%
% % % % %

%El encargado de cocinar un plato en el restaurante, el que mas experiencia tiene cocinandolo
encargadoDe(Empleado, Plato, Restaurante):-
    chef(Empleado, Restaurante),
    cocina(Empleado, Plato, Experiencia),
    forall(cocina(_, Plato, ExperienciaDelOtro), Experiencia >= ExperienciaDelOtro).

% Un plato puede ser entrada, principal o postre
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).
%plato(gomitas, postre(74)).

% % % % %
%Punto 6%
% % % % %

%guarnicion, cantidad de calorias
guarnicion(pure, 20).
guarnicion(papasFritas, 50).
guarnicion(ensalada, 0).

%relaciona cada tipo de plato con sus calorias
caloriasPorPlato(postre(Calorias), Calorias).

caloriasPorPlato(entrada(Ingredientes), Calorias) :-
    length(Ingredientes, CantidadDeIngredientes),
    Calorias is CantidadDeIngredientes * 15.

caloriasPorPlato(principal(Guarnicion,MinutosDeCoccion), Calorias) :-
    guarnicion(Guarnicion, CaloriasDeGuarnicion),
    Calorias is CaloriasDeGuarnicion + MinutosDeCoccion * 5.

esSaludable(NombreDelPlato) :-
    plato(NombreDelPlato, ContenidoDelPlato),
    caloriasPorPlato(ContenidoDelPlato, CaloriasDelPlato),
    CaloriasDelPlato < 75.

% % % % %
%Punto 7%
% % % % %

critico(antonEgo).
critico(christophe).
critico(cormillot).
critico(gordonRamsay).

%Un restaurante es especialista en aquellos platos que todos sus chefs saben cocinar bien
restauranteEspecialista(Restaurante, Plato) :-
    forall(chef(Persona,Restaurante), cocinaBien(Persona, Plato)).

ingredienteDeEntrada(Plato, Ingrediente) :-
    plato(Plato, entrada(Ingredientes)),
    member(Ingrediente, Ingredientes).

cartaDeRestaurante(Plato, Restaurante) :-
    cocina(Persona, Plato, _),
    trabajaEn(Restaurante, Persona).

entradasDeLaCarta(Plato, Restaurante) :-
    cartaDeRestaurante(Plato,Restaurante),
    plato(Plato, entrada(_)).

seMereceCriticaPositiva(Lugar, antonEgo) :-
    restauranteEspecialista(Lugar, ratatouille).

seMereceCriticaPositiva(Lugar, christophe) :-
    findall(Chef, chef(Chef, Lugar), Chefs),
    length(Chefs, CantidadDeChefs),
    CantidadDeChefs > 3.

seMereceCriticaPositiva(Lugar, cormillot) :-
    forall(esSaludable(Plato), cartaDeRestaurante(Plato,Lugar)),
    forall(ingredienteDeEntrada(Plato, zanahoria), entradasDeLaCarta(Plato, Lugar)).

criticaPositiva(Lugar, Critico) :-
    critico(Critico),
    inspeccionSatisfactoria(Lugar),
    seMereceCriticaPositiva(Lugar,Critico).