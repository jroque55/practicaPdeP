% jugadores 
jugador(jugador(Nombre, PuntosVida, PuntosMana,CartasMazo, CartasMano, CartasCampo)).

% cartas  
criatura(Nombre, PuntosDano, PuntosVida, CostoMana).
hechizo(Nombre, FunctorEfecto, CostoMana).

% efectos
dano(CantidadDano).
cura(CantidadCura).

nombre(jugador(Nombre,_,_,_,_,_), Nombre).
nombre(criatura(Nombre,_,_,_), Nombre).
nombre(hechizo(Nombre,_,_), Nombre).
vida(jugador(_,Vida,_,_,_,_), Vida).
vida(criatura(_,_,Vida,_), Vida).
vida(hechizo(_,curar(Vida),_), Vida).
dano(criatura(_,Dano,_), Dano).
dano(hechizo(_,dano(Dano),_), Dano).

mana(jugador(_,_,Mana,_,_,_), Mana).
mana(criatura(_,_,_,Mana), Mana).
mana(hechizo(_,_,Mana), Mana).
cartasMazo(jugador(_,_,_,Cartas,_,_), Cartas).
cartasMano(jugador(_,_,_,_,Cartas,_), Cartas).
cartasCampo(jugador(_,_,_,_,_,Cartas), Cartas).


%%%%%%%%%%%
%%Punto 1%%
%%%%%%%%%%%

esJugador(Nombre, Jugador):-
    jugador(Jugador),
    nombre(Jugador, Nombre).

tieneCarta(Jugador, Carta):-
    cartasDeJugador(Jugador, Cartas),
    member(Carta,Cartas).
    
cartasPorPartes(Nombre, Mazo, Mano, Campo):-
    esJugador(Nombre, Jugador),
    cartasCampo(Jugador, Campo),
    cartasMano(Jugador, Mano),
    cartasMazo(Jugador, Mazo).

cartasDeJugador(Nombre, Cartas):-
    esJugador(Nombre, Jugador),
    cartasPorPartes(Jugador, Mazo, Mano, Campo),
    union(Mano, Campo, EnJuego),
    union(EnJuego, Mazo, Cartas).

%%%%%%%%%%%
%%Punto 2%%
%%%%%%%%%%%

%un jugador es guerrero cuando todas las cartas que tiene, son criaturas

esCriatura(criatura(_,_,_,_)).

esGuerrero(Jugador):-
    jugador(Jugador),
    forall(tieneCarta(Jugador,Carta), esCriatura(Carta)).

%%%%%%%%%%%
%%Punto 3%%
%%%%%%%%%%%

empezarTurno(Nombre, jugador(Nombre, Vida, Mana,Mazo, Mano, Campo)):-
    esJugador(Nombre, Jugador),
    vida(Jugador, Vida),
    mana(Jugador, ManaAntes),
    cartasCampo(Jugador, Campo),
    Mana is ManaAntes + 1,
    agregarCarta(Jugador, Mazo, Mano).

agregarCarta(Jugador, Mazo, Mano):-
    cartasPorPartes(Jugador, [Carta | Cola], ManoAntes, _),
    append([Carta], ManoAntes, Mano).

%%%%%%%%%%%
%%Punto 4%%
%%%%%%%%%%%

puedeJugarCarta(Nombre, Carta):-
    esJugador(Nombre, Jugador),
    mana(Carta, ManaCarta),
    mana(Jugador, ManaJugador),
    ManaJugador >= ManaCarta.

puedeJugar(Jugador, Carta):-
    cartasMano(Jugador, Mano),
    member(Carta, Mano),
    puedeJugarCarta(Jugador, Carta).

cartasParaElProximoTurno(Nombre, Cartas):-
    empezarTurno(Nombre, Jugador),
    findall(Carta, puedeJugar(Jugador, Carta), Cartas).

%%%%%%%%%%%
%%Punto 6%%
%%%%%%%%%%%
