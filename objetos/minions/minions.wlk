class Minion {
    var rol
    var estamina

    method cambiarRol(nuevoRol) {
        rol = nuevoRol
    }

    method realizarTarea(){}

    method fuerza() = (estamina / 2) +2

}
class Biclopes inherits Minion {
    method recuperarEstamina(cantidad) = 10.min(estamina + cantidad)

    method fuerzaTotal() = rol.calcularFuerza(self)

    method dificultadDefensa(gradoAmenaza) = gradoAmenaza 

}

class Ciclope inherits Minion {
    method fuerzaTotal() = rol.calcularFuerza(self) / 2

    method dificultadDefensa(gradoAmenaza) = gradoAmenaza * 2

}


