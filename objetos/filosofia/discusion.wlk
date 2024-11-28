import filosofos.*

class Discusion {
    const partido1
    const partido2

    method esBuena() {
        return self.haySuficientesArgumentosBuenos() && self.estanEnLoCorrecto()
    }

    method haySuficientesArgumentosBuenos() {
        return (self.cantidadArgumentosBuenos() / self.cantidadArgumentos()) > 0.5
    }

    method estanEnLoCorrecto() {
        return partido1.estaEnLoCorrecto() && partido2.estanEnLoCorrecto()
    }

    method cantidadArgumentosBuenos() {
        return partido1.argumentosEnriquecedores() + partido2.argumentosEnriquecedores()
    }

    method cantidadArgumentos(){
        return partido1.cantidadArgumentos() + partido2.cantidadArgumentos()
    }

}

class Partido {
    var filosofo
    const argumentos

    method argumentosEnriquecedores() {
        return argumentos.count{argumento => argumento.esEnriquecedor()}
    }

    method cantidadArgumentos() {
        return argumentos.size()
    }

    method estaEnLoCorrecto() = filosofo.estaEnLoCorrecto()

}

class Argumento {
    var descripcion
    var naturaleza

    method esEnriquecedor() = naturaleza.enriquece(self)

    method cantidadDePalabras() = descripcion.words()

    method esPregunta() = descripcion.endsWith("?")

}

object estoica {
    method enriquece(argumento) = true
}

object moralista {
    method enriquece(argumento) = argumento.cantidadDePalabras() > 10
}

object esceptica {
    method enriquece(argumento) = argumento.esPregunta()
}

object cinica {
    method enriquece(argumento) = 1.randomUpTo(100) <= 30
}

class Combinada {
    const naturalezas 

    method enriquece(argumento) = naturalezas.all {
        naturaleza => naturaleza.enriquece(argumento)
    }

}