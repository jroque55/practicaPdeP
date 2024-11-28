

class Persona {
    const carrerasQueQuiereEstudiar = []
    const suenos = []
    const carrerasEstudiadas = []
    var cantHijos
    const lugaresVisitados = []
    const remuneracionPretendida
    var alcanzoRemuneracion = false
    var tipoDePersona
    var felicidad


    method cumplirSueno(sueno) {
        if(!self.suenosPendientes().contains(sueno)){
            throw new Exception(message = "El sueno no esta pendiente")
        }
        sueno.cumplirSueno(self)
    }

    method quiereEstudiar(carrera) {
        return carrerasQueQuiereEstudiar.contains(carrera)
    }

    method estudioCarrera(carrera) {
        return carrerasEstudiadas.contains(carrera)
    }

    method esUnSueno(sueno) = suenos.contains(sueno)

    method suenosPendientes() = suenos.filter{sueno => sueno.estaPendiente()}

    method completarCarrera(carrera) {
        carrerasQueQuiereEstudiar.remove(carrera)
    }

    method visitoLugar(lugar) {
        return lugaresVisitados.contains(lugar)
    }

    method visitarLugar(lugar) {
        lugaresVisitados.add(lugar)
    }

    method adoptarHijos(cantidad) {
        cantHijos += cantidad
    }

    method alcanzarRemuneracion(){
        alcanzoRemuneracion = true
    }

    method esRemuneracionPretendida(remuneracion) = remuneracion >= remuneracionPretendida

    method suenoElegido() {
        const sueno = tipoDePersona.elegirSueno(self.suenosPendientes())
        self.cumplirSueno(sueno)
    }

    method esFeliz() {
        return self.suenosPendientes().sum {suenio => suenio.felicidad()} > felicidad
    }

    method aumentarFelicidad(cantidad) {
        felicidad += cantidad
    }

}
class Suenos {
    var cumplido = false
    var felicidad = 0

    method estaPendiente() = !cumplido

    method cumplirSueno(persona) {
        self.validar(persona)
        self.realizar(persona)
        persona.aumentarFelicidad(felicidad)
        cumplido = true
    } 

    method realizar(persona)

    method validar(persona)
}

class Recibirse inherits Suenos{
    var carrera

    override method validar(persona) {
        if(persona.estudioCarrera(carrera)) {
            throw new Exception(message = "Ya estudio la carrera")
        }
        if(!persona.quiereEstudiar(carrera)){
            throw new Exception(message = "No quiere estudiar esa carrera")
        }
    }

    override method realizar(persona) {
        persona.completarCarrera(carrera)
    }

}

class AdoptarHijo inherits Suenos {
    const cantHijos

    override method validar(persona) {
        if(persona.tieneHijos()){
            throw new Exception(message = "No puede adoptar")
        }
    }

    override method realizar(persona){
        persona.adoptarHijos(cantHijos)
    }

}

class ViajarALugar inherits Suenos {
    const lugar

    override method validar(persona) {
        if(persona.visitoLugar(lugar)){
            throw new Exception(message = "Ya visito ese lugar")
        }
    }

    override method realizar(persona) {
        persona.visitarLugar(lugar)
    }

}

class ConseguirRemuneracion inherits Suenos {
    const remuneracion

    override method validar(persona) {
        if(!persona.esRemuneracionPretendida(remuneracion)){
            throw new Exception(message = "No es la remuneracion pretendida")
        }
    }

    override method realizar(persona) {
        persona.alcanzarRemuneracion()
    }

}

class SuenoMultiple inherits Suenos {
    const suenosIncluidos

    override method validar(persona) {
        suenosIncluidos.all {sueno => sueno.validar(persona)}
    }

    override method realizar(persona) {
        suenosIncluidos.forEach{sueno => sueno.realizar(persona)}
    }

}

object realista {

    method elegirSueno(suenos) {
        return suenos.max{suenio => suenio.felicidad()}
    }

}

object alocado {
    method elegirSueno(suenos) {
        return suenos.anyOne()
    }
}

object obsesivos {
    method elegirSueno(suenos) {
        return suenos.first()
    }
}
