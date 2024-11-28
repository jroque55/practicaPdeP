import actividades.*
class Filosofo {
    const nombre
    var nivelDeIluminacion
    var dias 
    const honorificos = #{}
    const actividades 

    method edad() = dias.div(365)

    method estaEnLoCorrecto() = nivelDeIluminacion > 1000

    method presentarse() {
        return nombre + honorificos.join(", ")
    }

    method realizarActividades() {
        actividades.forEach{actividad => actividad.realizarActividad(self)}
    }

    method nivelDeIluminacion() = nivelDeIluminacion

    method vivirUnDia() {
        self.realizarActividades()
        self.vivirDia()
        self.verificarCumpleAnios()
    }

    method aumentarNivelDeIluminacion(cantidad) {
        nivelDeIluminacion += cantidad
    }

    method disminuirNivelDeIluminacion(cantidad) {
        nivelDeIluminacion -= cantidad
    }

    method verificarCumpleAnios(){
        if(self.cumpleAnios()) {
            self.aumentarNivelDeIluminacion(10)
            self.verificarEsSabio()
        }
    }

    method verificarEsSabio() {
        if(self.edad() == 60){
            honorificos.add("El sabio")
        }
    }

    method cumpleAnios() = (dias % 365) == 0

    method vivirDia() {
        dias += 1
    }

    method rejuvenecerDias(cantidad) {
        dias -= cantidad
    }

}

const diogenes = new Filosofo(nivelDeIluminacion = 500, nombre = "Diogenes ", dias = 18253, honorificos = #{"El sabio", "Maestro"}, actividades = [])

class Contemporaneo inherits Filosofo {
    override method presentarse() = "hola"

    method amaAdmirarPaisajes() = actividades.contains(admirarElPaisaje)

    method coeficienteDeIluminacion() = if(self.amaAdmirarPaisajes()) 5 else 1

    override method nivelDeIluminacion() = super() * self.coeficienteDeIluminacion()

}