//
//  ViewController.swift
//  foursquareClone
//
//  Created by abdullah's Ventura on 15.05.2023.
//

import UIKit
import Parse
class SignInViewController: UIViewController {

    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
     
        
    }
    
    
    
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        if userNameTF.text != "" && passwordTF.text != ""{
            PFUser.logInWithUsername(inBackground: userNameTF.text!, password: passwordTF.text!) { user, error in
                if error != nil {
                    AlertManager.alert(title: "error", message: error?.localizedDescription ?? "undefined error", vc: self)
                }else{
                    self.performSegue(withIdentifier: "toListPlaces", sender: nil)
                }
            }
            
        }else{
            AlertManager.alert(title: "Login Error", message: "please check your username/password", vc: self)
        }
    }
    
    func testParseConnection(){
           let myObj = PFObject(className:"User")
           myObj[""] = "Hey ! First message from Swift. Parse is now connected"
           myObj.saveInBackground { (success, error) in
               if(success){
                   print("You are connected!")
               }else{
                   print("An error has occurred!")
               }
           }
       }
    
 
    
    /*
// parse set values
    func testParseConnection(){
           let myObj = PFObject(className:"User")
           myObj["ema"] = "Hey ! First message from Swift. Parse is now connected"
           myObj.saveInBackground { (success, error) in
               if(success){
                   print("You are connected!")
               }else{
                   print("An error has occurred!")
               }
           }
       }
    //parse getvalue
    func getData(){
        let query = PFQuery(className: "FirstClass")
        //filter
        query.whereKey("message", equalTo: "Hey ! First message from Swift. Parse is now connected")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription as Any)
            }else{
                print(objects as Any)
            }
        }
    }
    */
}

