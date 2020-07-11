//
//  AuthVC.swift
//  Store Project
//
//  Created by adol kazmy on 19/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import Firebase


class AuthVC : UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        try? Auth.auth().signOut()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user != nil {
                //User found
                self.performSegue(withIdentifier: "toApp", sender: self )
            } else {
                //There is no user here
                self.performSegue(withIdentifier: "toAuth", sender: self)
            }
        }
    }
}
