//
//  OrderInfoVC.swift
//  Store Project
//
//  Created by adol kazmy on 29/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import Firebase

class OrderInfoVC : UIViewController {
    
    var order : OrderObject!
    
    //Outlets:
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var AgeTxt: UITextField!
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let id = user?.uid {
                UserApi.getUser(id: id) { (userObj) in
                    let theUser = userObj
                    theUser.name = self.nameTxt.text
                    theUser.phoneNumber = self.phoneNumberTxt.text
                    theUser.address = self.addressTxt.text
                    theUser.age = Int(self.addressTxt.text!) ?? 0
                    theUser.upload()
                    print("upload data ready to apply purchase")
                    self.performSegue(withIdentifier: "toNext", sender: nil)
                    
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ConfirmationVC {
                destinationVC.order = order
            
        }
    }
}















