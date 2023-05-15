//
//  RegisterViewController.swift
//  foursquareClone
//
//  Created by abdullah's Ventura on 16.05.2023.
//

import UIKit
import Parse
class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var usernameRTF: UITextField!
    @IBOutlet weak var emailRTF: UITextField!
    @IBOutlet weak var passwordRTF: UITextField!
    @IBOutlet weak var confirmPasswdRTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        if passwordRTF.text == confirmPasswdRTF.text {
            if usernameRTF.text != "" || emailRTF.text != "" || passwordRTF.text != "" || confirmPasswdRTF.text != "" {
                
               let newUser = PFUser()
                newUser.username = usernameRTF.text!
                newUser.password = passwordRTF.text!
                newUser.email = emailRTF.text!
                newUser.signUpInBackground { success, error in
                    
                    
                    if error != nil {
                        AlertManager.alert(title: "sign up error", message: error?.localizedDescription ?? "undefined error", vc: self)
                     
                    }else{
                        //segue
                        self.performSegue(withIdentifier: "toListPlaces", sender: self)
                    }
                }
                
                
            }else{
                AlertManager.alert(title: "Error", message: "not be blank", vc: self)
            }
        }else{
            AlertManager.alert(title: "error", message: "password not match", vc: self)
        }
    }
    
}
