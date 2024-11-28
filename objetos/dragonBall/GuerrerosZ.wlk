import trajes.*

class GuerreroZ {
    var property potencialOfensivo
    var property nivelEnergia
    const nivelEnergiaBase  
    var experiencia
    var traje

    method atacar(unGuerrero){
        traje.protegerDano(self, unGuerrero)
        traje.efecto(self)
    }

    method aumentarExperiencia() {
        experiencia +=  1
    }

    method aumentarPorcentajeExperiencia(porcentaje) {
        experiencia += experiencia * porcentaje
    }

    method comerSemilla() {
        nivelEnergia = nivelEnergiaBase
    }

    method elegirTraje(unTraje) {
        traje = unTraje
    }

    method recibirDano(atacante, reduccion) {
        nivelEnergia -= atacante.potencialOfensivo() * (0.1 - reduccion/ 100 )
    }

    method aumentarPoderAtaque(porcentaje) {
        potencialOfensivo += potencialOfensivo * porcentaje
    }

}

class Saiyan inherits GuerreroZ{
    var nivelSaiyan
    var estaTransformado = false

    method transformarse(nivel) {
        nivelSaiyan = nivel
        estaTransformado = true
        self.aumentarPoderAtaque(0.5)
    }

    method estaTransformado() = estaTransformado

    method volverAEstadoBase() {
        estaTransformado = false
    }

    override method comerSemilla() {
        super()
        self.aumentarPoderAtaque(0.05)
    }

    override method recibirDano(atacante, reduccion) {
        if(! estaTransformado){
           nivelEnergia -= atacante.potencialOfensivo() * (0.1 - reduccion/ 100 )
        }else {
            nivelEnergia -= atacante.potencialOfensivo() * (0.1 - reduccion/ 100  - nivelSaiyan.resistencia()/100 )
        }

    }

}

object nivel1 {
    const property  resistencia = 5
}

object nivel2 {
    const property resistencia = 7
}

object nivel3 {
    const property resistencia = 15
}