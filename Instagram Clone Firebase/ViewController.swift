//
//  ViewController.swift
//  Instagram Clone Firebase
//
//  Created by Mahmut Şenbek on 9.10.2022.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil {
                    self.makeAlert(tittleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toMainScreenVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(tittleInput: "Empty section.", messageInput: "Please fill e-mail and password section.")
        }
    }
    
    @IBAction func signUpclicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil {
                    self.makeAlert(tittleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    
                    self.performSegue(withIdentifier: "toMainScreenVC", sender: nil)
                }
            }
            
            
        }else {
           makeAlert(tittleInput: "Empty section.", messageInput: "Please fill e-mail and password section.")
        }
        
    
    }
    func makeAlert(tittleInput:String, messageInput:String) {
        let alert = UIAlertController(title: tittleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok!", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}



