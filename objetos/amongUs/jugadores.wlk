import nave.*

class Jugador {
    var estaVivo = true
    var puedeVotar = true
    var personalidad
    var nivelSospecha = 40

    const mochila = []

    method buscarItem(item) {
        mochila.add(item)
    }

    method esSospechoso() = nivelSospecha >= 50

    method aumentarSospecha(unaCantidad) {
        nivelSospecha += unaCantidad
    }

    method tieneItem(item) {
        return mochila.contains(item)
    }

    method impugnarVoto() {
        puedeVotar = false
    }

    method nivelSospecha() = nivelSospecha

    method estaVivo() = estaVivo

    method llamarReunion() {
        nave.reunionDeEmergencia()
    }

}

class Tripulante inherits Jugador {

    const tareas = []

    method completoSusTareas() {
        return tareas.empty()
    }

    method tareaDisponible() = tareas.puedeRealizarla(self)

    method realizarTarea() {
        const tarea = self.tareaDisponible()
        tarea.hacer(self)
        tareas.remove(tarea)
        nave.terminarTarea(tarea)
    }

    method usar(item) {
        mochila.remove(item)
    }

    method expulsar() {
        estaVivo = false
        nave.expulsarTripulante()
    }

    method voto() =
        if(puedeVotar) {
            personalidad.voto()
        }else{
            self.votarEnBlanco()
        }
    
    method votarEnBlanco() {
        puedeVotar = true
        return votoEnBlanco
    }

}

class Impostor inherits Jugador {

    method sabotaje(unSabotaje) {
        self.aumentarSospecha(5)
        unSabotaje.realizar()
    }

    method voto() = nave.cualquierJugadorVivo()

    method expulsar() {
        estaVivo = false 
        nave.expulsarImpostor()
    }

}

object reducirOxigeno {
    method realizar() {
        nave.disminuirOxigeno(10)
    }
}

class ImpugnarUnJugador {
    const jugadorImpugnado

    method realizar() {
        jugadorImpugnado.impugnarVoto()
    }
}

object troll {
    method voto() = nave.jugadorNoSospechoso()
}