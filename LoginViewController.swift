
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginBtnAction(_ sender: UIButton) {
        // will be called when user finishes entering data and press login
        let userName = userNameTF.text
        let password = passwordTF.text
        let shouldGoToNextScreen = verifyUser(userName: userName, password: password)
        
        if shouldGoToNextScreen {
            //navigate
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "loginState")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesListVC") as! ViewController
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = vc
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            //print error msg
            print("User name or Password is incorrect")
        }
        
    }
    
    func verifyUser(userName:String?, password:String?) -> Bool{
        // ahmed as user name
        // 123456 as password
        if (userName == "ahmed" && password == "123456") {
            return true
        }else{
            return false
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
