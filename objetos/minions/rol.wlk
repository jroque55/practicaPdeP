import minions.*
class Rol {

    method calcularFuerza(empleado) = empleado.fuerza() 

    method herramientas() = []

}

class Obrero inherits Rol{
    const herramientas = []



}

class Soldado inherits Rol{
    var practica = 0

    override method calcularFuerza(empleado) = super(empleado) + practica

    method defenderSector(){
        self.aumentarPractica(2)
    }

    method aumentarPractica(cantidad) {
        practica += cantidad
    }


}

class Mucama inherits Rol{}