//
//  SignupVC.swift
//  Store Project
//
//  Created by adol kazmy on 17/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth



class SignupVC : UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repasswordTxt: UITextField!
    
    
    @IBAction func signupPressed(_ sender: Any) {
        
        if emailTxt.text != nil && passwordTxt.text != nil && repasswordTxt.text != nil && passwordTxt.text == repasswordTxt.text {
            
            Auth.auth().createUser(withEmail: emailTxt.text! , password: passwordTxt.text!) { (auth, error) in
                
                if error != nil {
                    print("error while signing up")
                } else {
                    print("new user has been created successfully :D")
                    Auth.auth().addStateDidChangeListener { (auth, user) in
                        guard let theUser = user else {return}

                        Firestore.firestore().collection("Users").document(theUser.uid).setData(["Email" : self.emailTxt.text!]) }
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            }
            
        } else {return}
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
