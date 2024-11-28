import invitados.*
object fiesta {
    const invitados = #{}

    method esUnBodrio() = invitados.all {invitado => not invitado.estaConforme()}

    method mejorDisfraz() {
        return invitados.max{invitado => invitado.puntajeDisfraz()}
    }

    method cambiarTraje(invitado, otroInvitado) {
        return self.esInvitado(invitado) && self.esInvitado(otroInvitado) && (not invitado.estaConforme() or not otroInvitado.estaConforme()) && (invitado.podriaUsarlo(otroInvitado.disfraz()) && otroInvitado.podriaUsarlo(invitado.disfraz()))
    }

    method esInvitado(invitado) {
        return invitados.contains(invitado)
    }

    method agregarInvitado(invitado) {
        if(self.esInvitado(invitado) && invitado.tieneDisfraz()){
            invitados.add(invitado)
        }
    }

    method fiestaInolvidable() {
        return invitados.all {invitado => invitado.esSexy() and invitado.estaConforme()}
    }

}