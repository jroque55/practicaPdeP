%trabaja(Nombre,Trabajo,CantHoras).
%estudia(Nombre,Carrera,Universidad).
trabaja(manuel, costura, 8).
trabaja(juan, sistemas, 8).
trabaja(sofia, arquitectura, 8).
trabaja(jesus, electricidad, 8).

estudia(juanma, sistemas, utn).
estudia(leandro, sistemas, utn).
estudia(juan, sistemas, utn).
estudia(sofia, arquitectura, uba).
estudia(manuel, quimica, utn).
estudia(juli, videojuegos, uade).

universidad(Nombre):- estudia(_,_,Nombre).
carreras(sistemas).
carreras(arquitectura).
carreras(quimica).


estudianteDeUniversidad(Alumno, Universidad):-
    estudia(Alumno, _, Universidad).

trabajaEstudiante(Alumno, Universidad):-
    estudia(Alumno, _, Universidad),
    trabaja(Alumno, _, _).

esObrera(Universidad):-
    universidad(Universidad),
    forall(estudianteDeUniversidad(Alumno, Universidad),trabajaEstudiante(Alumno,Universidad)).

estudiaMasCarreras(Alumno):-
    estudia(Alumno, _, Universidad),
    estudia(Alumno,_, OtraUniversidad),
    Universidad \= OtraUniversidad.

esExigente(Universidad):-
    universidad(Universidad),
    not(trabajaEstudiante(Alumno, Universidad)),
    not(estudiaMasCarreras(Alumno)).

porcentajeEstudiantesTrabajadores(Universidad, Porcentaje):-
    findall(_, estudia(_,_, Universidad), Estudiantes),
    findall(_, trabajaEstudiante(_, Universidad), Trabajadores),
    length(Estudiantes, CantidadEstudiantes),
    length(Trabajadores, CantidadTrabajadores),
    Porcentaje is (CantidadTrabajadores *100) / CantidadEstudiantes.
    
masEstudiantesTrabajadores(Universidad):-   
    universidad(Universidad),
    porcentajeEstudiantesTrabajadores(Universidad, Porcentaje),
    forall(porcentajeEstudiantesTrabajadores(_, OtroPorcentaje), Porcentaje > OtroPorcentaje).

trabajoDeLoQueEstudia(Persona, Trabajo):-
    trabaja(Persona, Trabajo, _),
    estudia(Persona, Trabajo, _).

diferentesAmbitos(Persona):-
    trabajaEstudiante(Persona, _),
    not(trabajoDeLoQueEstudia(Persona,_)).

carrerasDemandadas(Carrera):-
    carreras(Carrera),
    forall(estudia(Persona,Carrera,_), trabajoDeLoQueEstudia(Persona,Carrera)).