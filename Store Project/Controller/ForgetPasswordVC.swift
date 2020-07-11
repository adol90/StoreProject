//
//  ForgetPasswordVC.swift
//  Store Project
//
//  Created by adol kazmy on 17/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//


import UIKit
import Firebase


class ForgetPassword : UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        if let text = emailTxt.text {
            Auth.auth().sendPasswordReset(withEmail: text) { (error) in
                if error != nil {
                    self.simpleAlert(title: "Error", msg: "can't send reset email")
                }
            } } else {
            simpleAlert(title: "Error", msg: "text field is empty")
        }
    }
    
    
    @IBAction func BackPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}



