class Persona {
    const suenos = []
    const carreras = []
    const carrerasAEstudiar = []
    const lugaresVisitados = []
    var cantHijos
    const lugaresAViajar = []
    const cantPlata
    var nivelFelicidad = 0
    var personalidad

    method carrerasCompletadas(carrera) = carreras.contains(carrera)

    method elegirSueno() {
        const sueno = personalidad.elegir(self.suenosPendientes())
        self.cumplir(sueno)
    }

    method cumplir(sueno) {
        if(self.suenosPendientes().contains(sueno)) {
            throw new Exception(message = "El sueno ya esta cumplido")
        }else{
            sueno.cumplir(self)
        }
    }

    method remuneracionPretendida(remuneracion) {
        return remuneracion > cantPlata
    }

    method aumentarFelicidad(cantidad) {
        nivelFelicidad += cantidad
    }

    method quiereCarrera(carrera) = carrerasAEstudiar.contains(carrera)

    method tieneHijos() = cantHijos > 0

    method adoptar(cantidad) {
        cantHijos += cantidad
    }

    method quiereVisitar(lugar) = lugaresAViajar.contains(lugar)

    method visitarLugar(lugar) {
        lugaresVisitados.add(lugar)
    }

    method visitoLugar(lugar) {
        return lugaresVisitados.contains(lugar)
    }

    method suenosPendientes() {
        return suenos.filter {sueno => not sueno.cumplido()}
    }

    method felicidoniosPorObtener() {
        return self.suenosPendientes().sum {sueno => sueno.felicidonios()}
    }

    method esFeliz() {
        return nivelFelicidad > self.felicidoniosPorObtener()
    }

    method suenosAmbiciosos() {
        return suenos.filter {sueno => sueno.esAmbicioso()}
    }

    method esAmbicioso() = self.suenosAmbiciosos().size() > 3

    method personalidad(otraPersonalidad) {
        personalidad = otraPersonalidad
    }

}

object alocado {

    method elegir(suenos) {
        return suenos.anyOne()
    }

}

object realista {
    method elegir(suenos) {
        return suenos.max{sueno => sueno.felicidonios()}
    }
}

object obsesivo {
    method elegir(suenos) {
        return suenos.first()
    }
}