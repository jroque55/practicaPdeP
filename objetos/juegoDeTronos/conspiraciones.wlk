import casa.*
import personajes.*
class Conspiracion {
    var objetivo
    const complotados = []

    method cantidadTraidores() {
        const traidores = complotados.intersection(objetivo.aliados())
        return traidores.size()
    }

    method ejecutarConspiracion() {
        complotados.forEach{participante => participante.ejecutarAccion(objetivo)}
    }

    method objetivoCumplido() =  ! objetivo.esPeligroso()

}

object sutil {
    method ejecutarAccion(objetivo) {
        const casaPobre = casas.min{casa => casa.patrimonio()}
        const miembro = casaPobre.miembros().findOrElse({miembro => miembro.sePuedenCasar(objetivo) && miembro.estaVivo()}, throw new Exception(message = "No se pudo realizar el cometido"))
        miembro.agregarConyuge(objetivo)
    }
}

object asesino {
    method ejecutarAccion(objetivo) {
        objetivo.morir()
    }
}

object asesinoPrecavido {
    method ejecutarAccion(objetivo) {
      if(! objetivo.estaAcompanado()){
        objetivo.morir()
      }
    }
}

object disipados {

    method ejecutarAccion(objetivo) {
        objetivo.derrocharFortuna(0.1)
    }

}

object miedoso {
    method ejecutarAccion(objetivo){}
}