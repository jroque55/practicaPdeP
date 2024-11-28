import jugadores.*
object nave {
    var nivelOxigeno = 100
    var cantTripulantes = 0
    var cantImpostores = 0 
    const tripulantes = []

    method completaronLasTareas() {
       return tripulantes.all {tripulante => tripulante.completoSusTareas()}
    }

    method aumentarOxigeno(cantidad) {
        nivelOxigeno += cantidad
    }

    method jugadoresVivos() {
       return tripulantes.filter{jugador => jugador.estaVivo()}
    }

    method disminuirOxigeno(cantidad) {
        nivelOxigeno -= cantidad
        self.validarGanaronImpostores()
    }

    method terminarTarea(tarea) {
        if(self.completaronLasTareas()) {
            throw new Exception(message = "No hay mas tareas, Ganan los tripulantes")
        }
    }

    method validarGanaronImpostores() {
        if(cantImpostores == cantTripulantes || nivelOxigeno <= 0) {
            throw new DomainException(message = "Ganaron los Impostores")
        }
    }

    method jugadorNoSospechoso() {
        return tripulantes.findOrDefault({jugador => !jugador.esSospechoso()}, votoEnBlanco)
    }

    method jugadorSinItems() {
        return tripulantes.findOrDefault({jugador => !jugador.tieneItems()}, votoEnBlanco)
    }

    method jugadorMasSospechoso() {
        return tripulantes.max {jugador => jugador.nivelSospecha()}
    }

    method cualquierJugadorVivo() {
        return tripulantes.anyOne()
    }

    method expulsarImpostor() {
        cantImpostores -= 1
        if(cantImpostores == 0) {
            throw new Exception(message = "Ganaron los tripulantes")
        }
    }

    method expulsarTripulante() {
        cantTripulantes -= 1
        self.validarGanaronImpostores()
    }

    method reunionDeEmergencia() {
        const votos = self.jugadoresVivos().map{jugador => jugador.voto()}
        const masVotado = votos.max {alguien => votos.occurrencesOf(alguien)}
        masVotado.expulsar()
    }

}

object votoEnBlanco {
    method expulsar() {}
}