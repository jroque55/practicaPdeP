class Traje {
    var desgaste = 0

    method desgastar(cantidad){
        desgaste += cantidad
    }

    method cantidadPiezas() = 1

    method estaDesgastado() = desgaste >= 100

    method protegerDano(atacante, defensor) {
        if(self.estaDesgastado()){
            defensor.recibirDano(atacante, 0)
        }
    }

    method efecto(guerrero){
        if(self.estaDesgastado()){
            guerrero.aumentarExperiencia()
        }
    }

}

const trajecito = new Comunes(reduccion = 3)

class Comunes inherits Traje {
    const reduccion

    override method protegerDano(atacante, defensor) {
        super(atacante,defensor)
        if(!self.estaDesgastado()){
            self.desgastar(5)
            defensor.recibirDano(atacante, reduccion)
        }
    }

    override method efecto(guerrero){
        super(guerrero)
        guerrero.aumentarExperiencia()
    }

}

class Entrenamiento inherits Traje {
    var porcentajeAumento = 2

    method porcentajeAumento(nuevoPorcentaje) {
        porcentajeAumento = nuevoPorcentaje
    }

    override method efecto(guerrero) {
        super(guerrero)
        if(!self.estaDesgastado()){
            guerrero.aumentarPorcentajeExperiencia(porcentajeAumento)
        }

    }

}

class Modularizado inherits Traje {
    var piezas = []

    override method estaDesgastado() {
        return piezas.all{pieza => pieza.estaGastada()}
    }

    method piezasSinDesgastar() {
        return piezas.filter{pieza => not pieza.estaGastada()}
    }

    override method cantidadPiezas() = piezas.size()

    override method protegerDano(atacante, defensor) {
        super(atacante,defensor)
        if(!self.estaDesgastado()) {
            defensor.recibirDano(atacante, self.porcentajeReduccion())
            piezas.piezasSinDesgastar().forEach{pieza => pieza.desgastar(5)}
        }
    }

    method porcentajeReduccion() {
        return piezas.piezasSinDesgastar().sum {pieza => pieza.reduccion()}
    }

    override method efecto(guerrero) {
        super(guerrero)
        if(!self.estaDesgastado()) {
            guerrero.aumentarPorcentajeExperiencia(1 - self.piezasSinDesgastar()/ 100)
        }
    }

}

class Pieza {
    var desgaste = 0
    var reduccion

    method estaGastada() = desgaste >= 20

    method desgastar(cantidad) {
        desgaste += cantidad
    }

}