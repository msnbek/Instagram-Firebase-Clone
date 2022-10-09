//
//  SettingsViewController.swift
//  Instagram Clone Firebase
//
//  Created by Mahmut Şenbek on 9.10.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginScreenVC", sender: nil)
        }catch {
            print("error")
        }
        
        
    }
    
   

}
