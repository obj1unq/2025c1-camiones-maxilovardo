object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bulto(){return 1}
	method cambioAlCargarse(){}
}

object bumblebee{
	var property estado = auto
//false=auto, true=robot
	method peso() { return 800}
	method nivelPeligrosidad(){ return estado.nivelPeligrosidad() }
	method bulto(){return 2}
	method cambioAlCargarse(){estado.transformar(self)}
}

object robot {
	method nivelPeligrosidad(){30}
	method transformar(vehiculo){
		vehiculo.estado(auto)
	}
}
object auto {
	method nivelPeligrosidad(){15}
	method transformar(vehiculo){
		vehiculo.estado(robot)
	}
}

object paqueteDeLadrillos {
	const peso = 2
	var property cantidad = 1

	method peso() { return peso * self.cantidad() }
	method nivelPeligrosidad() { return 2 }
	method bulto(){return if(self.cantidad().between(0, 100)){1}
						  else if(self.cantidad().between(101, 300)){2}
						  else{3}}
	method cambioAlCargarse(){self.cantidad(12 + self.cantidad())}
}

object arenaAGranel {
	var property peso = 1

	method nivelPeligrosidad() { return 1 }
	method bulto(){return 1}
	method cambioAlCargarse(){self.peso(20 + self.peso())}
}

object bateriaAntiaerea {
	var property conMisiles = true
//true=con misiles, false=sin misiles
	method peso() { return if(self.conMisiles()){300}else{200} }
	method nivelPeligrosidad() { return if(self.conMisiles()){100}else{0} }
	method bulto(){return if(conMisiles){2}else{1}}
	method cambioAlCargarse(){self.conMisiles(true)}
}

object contenedorPortuario {
	const contenidos = []

	method peso() { return 100 + contenidos.sum({cosa => cosa.peso()}) }
	method nivelPeligrosidad() { return if(contenidos.isEmpty()){0}else{self.peligrosidadDeElementoMasPeligroso()}}
	method peligrosidadDeElementoMasPeligroso(){return contenidos.max({cosa => cosa.nivelPeligrosidad()})}
	method bulto(){return 1 + contenidos.sum({cosa => cosa.bulto()}) }
	method cambioAlCargarse(){contenidos.all({cosa => cosa.cambioAlCargarse()})}
}

object residuosRadiactivos {
	var property peso = 1

	method nivelPeligrosidad() { return 200 }
	method bulto(){return 1}
	method cambioAlCargarse(){self.peso(15 + self.peso())}
}

object embalajeDeSeguridad {
	const contenido = knightRider

	method peso() { return contenido.peso() }
	method nivelPeligrosidad() { return contenido.nivelPeligrosidad()/2 }
	method bulto(){return 2}
	method cambioAlCargarse(){}
}