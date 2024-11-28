class Guerrero {
    var potencialOfensivo
    const energiaOriginal
    var nivelExperiencia
    var energia
    var traje

    method atacar(guerrero) {
        traje.experienciaRecibida(self)
        guerrero.recibirDano(self)
    }

    method danoPorAtaque(porcentaje) = if(porcentaje > 0) potencialOfensivo * 0.1 else potencialOfensivo * (0.1 - porcentaje / 100)

    method traje(otroTraje) {
        traje = otroTraje
    }

    method disminuirEnergia(cantidad) {
        energia -= cantidad
    }

    method aumentarExperiencia(cantidad) {
        nivelExperiencia += cantidad
    }

    method comerSemilla() {
        energia = energiaOriginal
    }

    method recibirDano(atacante) {
        traje.proteger(atacante, self)
    }

    method portencialOfensivo() = potencialOfensivo

    method nivelEnergia() = (energia / energiaOriginal) * 100

    method aumentarPoder(porcentaje) {
        potencialOfensivo += potencialOfensivo * porcentaje / 100
    }

}

class Saiyan inherits Guerrero {
    var fase

    method transformarse(otraFase) {
        fase = otraFase
    }

    method verificarEnergia() {
        if(self.nivelEnergia() <= 1) {
            self.transformarse(base)
        }
    }

    override method recibirDano(atacante) {
        self.verificarEnergia()
        super(atacante)
    }

    override method comerSemilla() {
        super()
        self.aumentarPoder(5)
    }

}

const base = new Fase(resistencia = 0)

class Fase {
    const resistencia

    method resistencia() = resistencia

}

