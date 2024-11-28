class Invitado {
    var disfraz 
    var personalidad
    const exigencia

    method disfraz(otroDisfraz) {
        disfraz = otroDisfraz
    }

    method esSexy() {
        return personalidad.esSexy(self)
    }

    method personalidad(otraPersonalidad) {
        personalidad = otraPersonalidad
    }

    method estaConforme() {
        return self.puntajeDisfraz() > 10 and exigencia.estaConforme(disfraz, self)
    }

    method puntajeDisfraz() {
        return disfraz.puntaje(self)
    }

    method tieneDisfraz() {
        return disfraz != sinDisfraz
    }

    method podriaUsarlo(otroDisfraz) {
        return exigencia.estaConforme(otroDisfraz,self)
    }


}

object alegre {
    method esSexy(_) = false
}

object taciturna {
    method esSexy(persona) = persona.edad() < 30
}

object caprichoso {
    method estaConforme(disfraz, _) = disfraz.largoNombre() % 2 == 0
}

object pretencioso {
    method estaConforme(disfraz, _) = disfraz.diasDesdeConfeccion() > 30
}

class Numerologo {
    const cifra
    method estaConforme(disfraz, disfrazado) = cifra == disfraz.puntaje(disfrazado)
}

object sinDisfraz {

}