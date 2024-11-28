class Casa {
    var patrimonio 
    const miembros = []

    method ambosPuedenCasarse(conyuge, miembro) {
        if(self.puedenCasarse(conyuge) && conyuge.casa().puedenCasarse(miembro)){
            miembro.agregarConyuge(conyuge) 
            conyuge.agregarConyuge(miembro)
        }else {
            throw new Exception (message = "No se pueden casar")
        }
        
    }

    method puedenCasarse(conyuge)

    method esRica() = patrimonio > 1000

    method patrimonioDeMiembro() {
        return patrimonio / self.cantidadMiembros()
    }

    method cantidadMiembros() {
        return miembros.size()
    }

    method perderDinero(porcentaje) {
        patrimonio -= patrimonio*porcentaje
    }

}

object lannister inherits Casa (patrimonio = 100){
    override method puedenCasarse(conyuge) {
      return  conyuge.cantidadConyuges()  < 2
    }
}

object stark inherits Casa (patrimonio = 1001){
    override method puedenCasarse(conyuge) = conyuge.casa() != self
}

object guardiaDeLaNoche inherits Casa (patrimonio = 200){
    override method puedenCasarse(_) = false
}

const casas = [stark,lannister,guardiaDeLaNoche]