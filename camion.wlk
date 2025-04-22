import cosas.*

object camion {
	const property cosas = #{}
	const pesoMaximo = 2500
		
	method cargar(cosa) {
		cosas.add(cosa)
		cosa.cambioAlCargarse()
	}

	method descargar(cosa){
		cosas.remove(cosa)
	}

	method todoPesoPar(){
		return cosas.all({cosa => cosa.even()})
	}

	method hayAlgunoQuePesa(peso){
		return cosas.any({cosa => cosa.peso() == peso})
	}

	method elDeNivel(nivel){
		return cosas.find({cosa => cosa.nivelPeligrosidad() == nivel})
	}

	method pesoTotal(){
		return cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso(){
		return self.pesoTotal() > pesoMaximo
	}

	method objetosQueSuperanPeligrosidad(nivel){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(cosa){
		return self.objetosQueSuperanPeligrosidad(cosa.nivelPeligrosidad())
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad){
		return not self.excedidoDePeso() && self.objetosQueSuperanPeligrosidad(nivelMaximoPeligrosidad).isEmpty()
	}

	method tieneAlgoQuePesaEntre(min, max){
		return self.pesos().between(min, max)
	}

	method pesos(){
		return cosas.map({cosa => cosa.peso()})
	}

	method cosaMasPesada(){
		return cosas.max({cosa => cosa.peso()})
	}

	method totalBultos(){
		return cosas.sum({cosa => cosa.bulto()})
	}

	method transportar(destino, camino){
		self.validarTransportar(destino, camino)
		destino.agregarElementos(self.cosas())
	}

	method validarTransportar(destino, camino){
		return if(not camino.soportaViaje(self) || self.excedidoDePeso() || not destino.tieneCapacidad(self)){
			self.error("no puede transportar")
		}
	}
}

object ruta9 {
	const peligrosidad = 11

	method soportaViaje(vehiculo){
		return vehiculo.puedeCircularEnRuta(peligrosidad)
	}
}

object caminoVecinal {
	var property pesoSoportado = 0

	method soportaViaje(vehiculo){
		return vehiculo.pesoTotal() <= self.pesoSoportado()
	}
}

object almacen {
	const property cosas = #{}
	var property capacidad = 1

	method tieneCapacidad(vehiculo){
		return vehiculo.totalBultos() <= self.capacidad()
	}

	method agregarElementos(elementos){
		cosas.addAll(elementos)
	}
}