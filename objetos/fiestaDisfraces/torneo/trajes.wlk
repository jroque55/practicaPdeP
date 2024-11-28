class Traje {
    var desgaste = 0

    method desgastar(){
        desgaste -= 5
    }

    method proteger(atacante, defensor){
        if(self.estaDesgastado()){
            const danoHecho = atacante.danoPorAtaque(0)
            defensor.disminuirEnergia(danoHecho)
        }
    } 

    method experienciaRecibida(guerrero){
        guerrero.aumentarExperiencia(1)
    }

    method estaDesgastado() = desgaste == 100

}

class Comunes inherits Traje {
    const porcentaje

    override method proteger(atacante, defensor) {
        super(atacante,defensor)
        if(!self.estaDesgastado()){
            self.desgastar()
            const danoHecho = atacante.danoPorAtaque(porcentaje)
            defensor.disminuirEnergia(danoHecho)
        }
    }

}

class DeEntrenamiento inherits Traje {
    const multiplicador = 2 

    override method experienciaRecibida(guerrero){
        guerrero.aumentarExperiencia(multiplicador)
    }

}

class Modularizados inherits Traje {
    const modulo = []

    override method estaDesgastado() {
        return modulo.all {pieza => pieza.estaDesgastada()}
    }

    method piezasUtiles() = modulo.filter {pieza => not pieza.estaDesgastada()}

    override method proteger(atacante, defensor) {
        super(atacante,defensor)
        if(!self.estaDesgastado()) {
            const danoHecho = atacante.danoPorAtaque(self.resistencia())
            defensor.disminuirEnergia(danoHecho)
        }
    }

    method resistencia() {
        return self.piezasUtiles().sum {pieza => pieza.resistencia()}
    }

    method porcentajePiezasUtiles() = modulo.size() / self.piezasUtiles() 

    override method experienciaRecibida(guerrero) {
        guerrero.aumentarExperiencia(self.porcentajePiezasUtiles())
    }


}

class Pieza {
    var desgaste = 0 
    const resistencia

    method estaDesgastada() = desgaste >= 20

    method desgastar() {
        desgaste += 5
    }

    method resistencia() = resistencia


}
