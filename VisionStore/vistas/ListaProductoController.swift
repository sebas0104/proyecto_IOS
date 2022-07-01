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
        db.collection("Producto").getDocuments{
            (querySnapshot, err) in
            self.listaProductos.removeAll()
            if let err = err{
                print("Error al traer los productos: \(err)")
            }else{
                for document in
                        querySnapshot!.documents{
                    let producto = Producto(IDproducto: document.data()["IDproducto"] as! Int,
                        Nomproduc:document.data()["Nomproduc"] as! String,Descripcion: document.data()["Descripcion"] as! String, Cantidad: document.data()["Cantidad"] as! Int, Precio: document.data()["Precio"] as! Double)
                    
                    self.listaProductos.append(producto)
                    self.tablaProductos.reloadData()                }
                
            }
        }
        
    }
    
    

}
