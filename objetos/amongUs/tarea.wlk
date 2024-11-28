import nave.*


class Tarea {
    const itemsNecesario

    method puedeRealizarla(jugador) {
        return itemsNecesario.all {item => jugador.tieneItem(item)}
    }

    method hacer(jugador) {
        self.afectar(jugador)
        self.usarItemsNecesarios(jugador)
    }

    method usarItemsNecesarios(jugador) {
        itemsNecesario.forEach {item => jugador.usar(item)}
    }

    method afectar(_) 

}

object arreglarTablero inherits Tarea(itemsNecesario = ["llave inglesa"]) {
    override method afectar(jugador) {
        jugador.aumentarSospecha(10)
    }
}

object sacarBasura inherits Tarea(itemsNecesario = ["escoba", "bolsa de consorcio"]) {
    override method afectar(jugador) {
        jugador.disminuirSospecha(4)
    }
}

object ventilarNave inherits Tarea(itemsNecesario = []) {
    override method afectar(jugador) {
        nave.aumentarOxigeno(5)
    }
}