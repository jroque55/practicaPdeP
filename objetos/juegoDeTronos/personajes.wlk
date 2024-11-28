class Personaje {
    const casa
    const conyuges = []
    var estaVivo = true
    const acompanantes = []
    var personalidad

    method patrimonio() {
        return casa.patrimonioDeMiembro()
    }

    method sePuedenCasar(conyuge) {
        return casa.puedenCasarse(conyuge) && conyuge.casa().puedenCasarse(self)
    }

    method agregarConyuge(conyuge) {
        conyuges.add(conyuge)
    }

    method cantidadConyuges() = conyuges.size()
    
    method esAliado(persona) = self.aliados().contains(persona)

    method aliados() = conyuges + acompanantes + casa.miembros()

    method estaAcompanado() = self.aliados().size() >0

    method esDeCasaRica() = casa.esRica()

    method casa() = casa

    method esPeligroso() = estaVivo && (self.aliadosSuperanRiqueza(10000) || self.conyugesDeCasaRica() || self.tieneAliadoPeligroso())

    method aliadosSuperanRiqueza(cantidad) =
        self.aliados().sum {aliado => aliado.patrimonio()} > cantidad
    
    method conyugesDeCasaRica() =
        conyuges.all {conyuge => conyuge.esDeCasaRica()}

    method tieneAliadoPeligroso() = self.aliados().any{aliado => aliado.esPeligroso()}

    method morir() {
        estaVivo = false
    }

    method derrocharFortuna(porcentaje){
        casa.perderDinero(porcentaje)
    }

}