
import UIKit
import  FirebaseAuth
class ViewController: UIViewController {
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnRegistrar: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registrar(_ sender: Any) {
        if let correo = txtCorreo.text, let password = txtPassword.text{
            Auth.auth().createUser(withEmail:correo, password: password){
                (result,error) in
                                if let result = result , error == nil{
                                    print("REGISTRO CORRECTO")
                                    let  alertController = UIAlertController(title:"CORRECTO",
                                                           message:"USUARIO REGISTRADO",
                                                           preferredStyle: .alert)
                                                       alertController.addAction(UIAlertAction(title: "ACEPTAR", style: .default))
                                               self.present(alertController, animated: true , completion: nil)
                                    self.txtCorreo.text = ""
                                    self.txtPassword.text = ""
            }else{
                let  alertController = UIAlertController(title:"ERROR",
                    message:"ERROR AL REGISTRAR EL USUARIO",
                    preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ACEPTAR", style: .default))
        self.present(alertController, animated: true , completion: nil)
                
            }
        }
    }
        
}
    
}
