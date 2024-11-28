class Animal {
    method patrimonio() = 0
    method esPeligroso()
}
class Dragon inherits Animal {
    override method esPeligroso() = true
}

class Lobo inherits Animal {
    var especie 

    override method esPeligroso() = especie == huargo
}

object huargo {
    
}