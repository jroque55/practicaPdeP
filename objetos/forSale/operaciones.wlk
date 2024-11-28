import inmobiliaria.*


class Operacion {
    const inmueble
    var estado = disponible

    method comision() 

    method zona() = inmueble.zona()

    method cerrarPara(cliente, empleado) {
        estado.cerrarPara(cliente,empleado,self)
    }

    method reservarPara(cliente, empleado) {
        estado.reservarPara(cliente, empleado,self)
    }

    method estado(nuevoEstado) {
        estado = nuevoEstado
    }

}

class Alquiler inherits Operacion{
    const cantMeses 
    override method comision() = (cantMeses * inmueble.valor()) / 50000
}

class Venta inherits Operacion{

    override method comision() = (inmobiliaria.porcentajeComision() / 100) * inmueble.valor()

}

class EstadoOperacion {

    method reservarPara(cliente,empleado, operacion)

    method validarCierrePara(cliente,empleado,operacion)

    method cerrarPara(cliente,empleado, operacion){
        self.validarCierrePara(cliente, empleado,operacion)
        operacion.estado(cerrada)
    }

}

object disponible inherits EstadoOperacion{

    override method validarCierrePara(cliente,empleado,operacion) {
        empleado.agregarOperacion(operacion)
        cliente.agregarOperacion(operacion)
    }

    override method reservarPara(cliente,empleado, operacion){
        cliente.agregarReserva(operacion)
        empleado.agregarReserva(operacion)
    }

}

class Reservada inherits EstadoOperacion {
    const clienteQueReservo

    override method validarCierrePara(cliente,empleado,operacion) {
        if(cliente != clienteQueReservo){
            throw new DomainException(message = "No es la misma persona que reservo")
        }
    }
    override method reservarPara(cliente,empleado,operacion){
        throw new DomainException(message = "Ya esta reservada")
    }
}

object cerrada inherits EstadoOperacion {
    override method validarCierrePara(cliente,empleado,operacion) {
        throw new DomainException(message = "Ya esta cerrada")
    }
    override method reservarPara(cliente,empleado,operacion){
        throw new DomainException(message = "Ya esta cerrada")
    }
}
