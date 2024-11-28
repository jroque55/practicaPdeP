class Inmueble {
    const metrosCuadrados
    var zona
    const cantAmbientes
    const operacion

    method valorParticular() 

    method valor() = self.valorParticular() + zona.valor()

}

class Casa inherits Inmueble{
    const valorParticular
    override method valorParticular() = valorParticular
}

class Ph inherits Inmueble {
    override method valorParticular() = 500000.min(metrosCuadrados * 14000)
}

class Departamento inherits Inmueble {
    override method valorParticular() = cantAmbientes * 350000
}

class Zona {
    var valorDeZona
    method valor() = valorDeZona
    method valorDeZona(nuevoValor){
        valorDeZona = nuevoValor
    }
}