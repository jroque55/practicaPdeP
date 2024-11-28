import minions.*
import rol.*

class Tarea {
    method realizarTarea(empleado) {
        self.comprobarQuePuedeRealizar(empleado)
        empleado.realizarTarea(self)
    }

    method comprobarQuePuedeRealizar(empleado) {
        if(!self.puedeRealizarla(empleado)){
            throw new Exception(message = "No puede realizar la tarea")
        }
    }

    method puedeRealizarla(_)

    method estaminaQueGasta(_)

}

class ArreglarMaquina inherits Tarea {
    var maquina

    override method puedeRealizarla(empleado) =
        maquina.complejidad() <= empleado.estamina() && empleado.tieneItems(maquina.itemsNecesarios())

    method dificultad() = maquina.complejidad() * 2
 
    override method estaminaQueGasta(_) = maquina.complejidad()
}

class maquina {
    var complejidad
    var itemsNecesarios

    method itemsNecesarios() = itemsNecesarios

    method complejidad() = complejidad

}

class DefenderSector inherits Tarea {
    var gradoAmenaza


    override method puedeRealizarla(empleado) =
        empleado.rol() != Mucama && empleado.fuerza() >= gradoAmenaza

    override method estaminaQueGasta(empleado) {
        if(empleado.rol() != Soldado){
            return empleado.estamina() / 2
        } else{
            return 0
        }
    }

    method dificultad(empleado) = empleado.dificultadDefensa(gradoAmenaza)

}