class Consumo {

    const property fechaRealizado = new Date()

    method cubreLlamada(pack) = false

    method cubreInternet(pack) = false


}

class ConsumoDeInternet inherits Consumo {
    const cantMB    

    method costo() = cantMB * pdepfoni.precioMB()

    override method cubreInternet(pack) = pack.puedeGastarMB(cantMB)

}

class ConsumoDeLlamadas inherits Consumo {
    const segundos

    method segundosContados() = if(segundos > 30) 0 else (segundos - 30)

    method costo() = pdepfoni.precioFijoLlamada() + self.segundosContados() * pdepfoni.precioLlamada()

    override method cubreLlamada(pack) = pack.puedeGastarMinutos(self.segundosContados())

}

object pdepfoni {
    method precioLlamada() = 0.05
    method precioMB() = 0.10
    method precioFijoLlamada() = 1
}