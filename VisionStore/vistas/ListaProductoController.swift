import UIKit
import FirebaseFirestore

class ListaProductoController: UIViewController,
                               UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tablaProductos: UITableView!
    var listaProductos = [Producto]()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            self.listarProductos()
            tablaProductos.dataSource = self
            tablaProductos.delegate = self
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            listaProductos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let celda = tablaProductos.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let producto = listaProductos[indexPath.row]
            
            celda.textLabel?.text = producto.toString()
            
            return celda
        }
        

        func listarProductos(){
            
            let db = Firestore.firestore()
            db.collection("producto_prueba").getDocuments{
                (querySnapshot, err) in
                self.listaProductos.removeAll()
                if let err = err{
                    print("Error al traer los productos: \(err)")
                }else{
                    for document in
                            querySnapshot!.documents{
                        let producto = Producto(IDproducto: document.data()["IDproducto"] as! Int, Descripcion: document.data()["Descripcion"] as! String, Cantidad: document.data()["Cantidad"]as! Int, Precio: document.data()["Precio"]as!String)
                        
                        self.listaProductos.append(producto)
                        self.tablaProductos.reloadData()                }
                    
                }
            }
            
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVc = segue.destination as!
        ProductoFormViewController
            destinationVc.productoForm.IDproducto = listaProductos.count + 1
        }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
         
         let editar = UITableViewRowAction(style: .normal, title: "EDITAR"){
             (action, indexPath)in
             print("editando:"+String(self.listaProductos[indexPath.row].IDproducto))
             
             // ABRIR PRODUCTOFORM
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductoFormViewController") as! ProductoFormViewController
             // mando los datos del producto de la fila
             vc.productoForm = self.listaProductos[indexPath.row]
             self.navigationController?.pushViewController(vc, animated: true)
             
         }
         editar.backgroundColor = UIColor.blue
         
         let eliminar = UITableViewRowAction(style: .destructive, title: "ELIMINAR"){
             (action, indexPath) in
             print("eliminando:" + String(self.listaProductos[indexPath.row].IDproducto))
             
             let db = Firestore.firestore()
             let productoReference = db.collection("producto_prueba").document(String(self.listaProductos[indexPath.row].IDproducto))
             productoReference.delete()
             self.listarProductos()
         }
         
         return [editar, eliminar]
     }
}
