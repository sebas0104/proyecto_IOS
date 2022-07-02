

import UIKit
import FirebaseFirestore
class ProductoFormViewController: UIViewController {
    @IBOutlet weak var txtProducto: UITextField!
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var txtCantidad: UITextField!
    @IBOutlet weak var txtPrecio: UITextField!
    
    
    var productoForm: Producto = Producto(IDproducto: 0, Descripcion: "", Cantidad: 0, Precio: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ingresando a ProductoForm")

        txtProducto.text = String(productoForm.IDproducto)
        txtDescripcion.text = String(productoForm.Descripcion)
        txtCantidad.text = String(productoForm.Cantidad)
        txtPrecio.text = String(productoForm.Precio)
    }
    @IBAction func guardar(_ sender: Any) {
        
        
        let productoSave = ["IDproducto": Int(txtProducto.text!)!,
                            "Descripcion": txtDescripcion.text!,
                            "Cantidad": Int(txtCantidad.text!)!,
                            "Precio": txtPrecio.text!
        ] as [String: Any]
        
        let db = Firestore.firestore()

        db.collection("producto_prueba").document(String(productoForm.IDproducto)).setData(productoSave)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListaProductoController") as! ListaProductoController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
