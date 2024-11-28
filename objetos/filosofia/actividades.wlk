import filosofos.*
object tomarVino{
    method realizarActividad(unFilosofo){
        unFilosofo.disminuirNivelDeIluminacion(10)
    }
}

class JuntarseEnElAgora {
    const filosofo

    method realizarActividad(unFilosofo) {
        unFilosofo.aumentarNivelDeIluminacion(filosofo.nivelDeIluminacion() /10)
    }

}

object admirarElPaisaje {
    method realizarActividad(unFilosofo){
        //NO HACE NADA
    }
}

class MeditarBajoUnaCascada {
    const metros

    method realizarActividad(unFilosofo) {
        unFilosofo.aumentarNivelDeIluminacion(metros * 10)
    }

}

class PracticarDeporte {
    const deporte

    method realizarActividad(unFilosofo) {
        unFilosofo.rejuvenecerDias(deporte.diasQueRejuvenece())
    }

}

object polo {
    method diasQueRejuvenece() = 2
}
object futbol {
    method diasQueRejuvenece() = 1
}

object waterpolo {
    method diasQueRejuvenece() = polo.diasQueRejuvenece() * 2
}
