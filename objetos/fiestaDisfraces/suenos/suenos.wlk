class Sueno {
    const felicidonios
    var cumplido = false

    method cumplir(persona) {
        self.validar(persona)
        self.realizar(persona)
        persona.aumentarFelicidad(self.felicidonios())
        self.cumplir()
    }

    method felicidonios() = felicidonios

    method validar(persona)

    method cumplir() {
        cumplido = true
    }

    method realizar(persona)

    method cumplido() = cumplido

}

class RecibirseDeUnaCarrera inherits Sueno {
    const carrera

    override method realizar(persona) {
        persona.aumentarFelicidad(felicidonios)
        persona.suenoCumplido(self)
    }

    override method validar(persona) {
        if(persona.carrerasCompletadas(carrera)) {
            throw new Exception(message = "Ya completo la carrera")
        }
        if(! persona.quiereCarrera(carrera)){
            throw new Exception(message = "No esta interesado en esa carrera")
        }
    }

}

class ConseguirRemuneracion inherits Sueno {
    const remuneracion

    override method realizar(persona){}

    override method validar(persona) {
        if(! persona.remuneracionPretendida(remuneracion)) {
            throw new DomainException(message = "No es la remuneracion pretendida")
        }
    }

}

class AdoptarHijos inherits Sueno {
    const cantidad
    
    override method realizar(persona) {
        persona.tenerHijo(cantidad)
    }

    override method validar(persona) {
        if(persona.tieneHijos()) {
            throw new Exception (message = "Ya tiene hijos")
        }
    }

}

class ViajarAUnLugar inherits Sueno {
    const lugar

    override method realizar(persona) {
        persona.visitarLugar(lugar)
    }

    override method validar(persona) {
        if(persona.visitoLugar(lugar)) {
            throw new Exception(message = "Ya visito ese lugar")
        }if(!persona.quiereVisitar()) {
            throw new Exception(message = "No es un lugar que quiera visitar")
        }
    } 

    method esAmbicioso() = self.felicidonios() > 100

}

class SuenoMultiple inherits Sueno {
    const suenos = []

    override method validar(persona) {
        suenos.forEach{sueno => sueno.validar(persona)}
    }

    override method realizar(persona) {
        suenos.forEach{sueno => sueno.realizar(persona)}
    }

    override method felicidonios() = suenos.sum {sueno => sueno.felicidonios()}

}