class Disfraz {
    const nombre
    const caracteristicas = []
    const diasDesdeConfeccion

    method puntaje(disfrazado) {
        return caracteristicas.sum {caracteristica => caracteristica.puntajeParticular(disfrazado)}
    }

    method largoNombre() = nombre.words()

    method diasDesdeConfeccion() = diasDesdeConfeccion

}

class Graciosos {
    const nivelDeGracia 

    method puntajeParticular(disfrazado) {
        if(disfrazado.edad() > 50){
            return nivelDeGracia * 3
        }else{
            return nivelDeGracia
        }
    }

}

class Tobaras {
    const fechaDeCompra

    method puntajeParticular(_) {
        if(fechaDeCompra  > 2){
            return 5
        }else{ 
            return 3
        }
    }
}
const papaleta = new Disfraz(nombre = "Papaletaaa", caracteristicas = [new Graciosos(nivelDeGracia = 5), new Tobaras(fechaDeCompra = 3), sexy], diasDesdeConfeccion = 30)
class Caretas {
    const personaje

    method puntajeParticular(_) = personaje.valor()
}

object sexy {
    method puntajeParticular(disfrazado) = if(disfrazado.esSexy()) 15 else 2
}