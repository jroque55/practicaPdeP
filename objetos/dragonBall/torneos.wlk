object powerIsBest {
    method clasificados(guerreros) {
        return guerreros.sortBy{guerrero1, guerrero2 => guerrero1.potencialOfensivo() > guerrero2.potencialOfensivo()}.take(16)
    }
}

object funny {
    method clasificados(guerreros) {
        return guerreros.sortBy{guerrero1, guerrero2 => guerrero1.traje().cantidadPiezas() > guerrero2.traje().cantidadPiezas()}.take(16)
    }
}

object surprise {
    method clasificados(guerreros) {
        return guerreros.take(16)
    }
}