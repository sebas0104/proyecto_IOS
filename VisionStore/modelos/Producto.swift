import Foundation
class Producto{

var IDproducto: Int
var Descripcion: String
var Cantidad: Int
var Precio: String

init(IDproducto: Int,Descripcion: String,Cantidad: Int,Precio: String){
    self.IDproducto = IDproducto
    self.Descripcion = Descripcion
    self.Cantidad = Cantidad
    self.Precio = Precio
    
}

func toString()-> String{
    return "Producto:  \(Descripcion) -\(Cantidad)- S/. \(Precio)"
}
    
}
