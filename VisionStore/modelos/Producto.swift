import Foundation
class Producto{

var IDproducto: Int
var Nomproduc: String
var Descripcion: String
var Cantidad: Int
var Precio: Double

init(IDproducto: Int,Nomproduc: String,Descripcion: String,Cantidad: Int,Precio: Double){
    self.IDproducto = IDproducto
    self.Nomproduc = Nomproduc
    self.Descripcion = Descripcion
    self.Cantidad = Cantidad
    self.Precio = Precio
    
}

func toString()-> String{
    return "Producto: \(Nomproduc) - \(Descripcion) -\(Cantidad)- S/. \(Precio)"
}
    
}
