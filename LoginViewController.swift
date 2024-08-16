
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    @IBAction func loginBtnAction(_ sender: UIButton) {
       
        let userName = userNameTF.text
        let password = passwordTF.text
        let shouldGoToNextScreen = verifyUser(userName: userName, password: password)
        
        if shouldGoToNextScreen {
           
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "loginState")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesListVC") as! ViewController
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            print("User name or Password is incorrect")
        }
        
    }
    
    func verifyUser(userName:String?, password:String?) -> Bool{
       
        if (userName == "ahmed" && password == "123456") {
            return true
        }else{
            return false
        }
        
    }

    }

}
