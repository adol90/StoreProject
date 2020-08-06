//
//  ConfirmationVC.swift
//  Store Project
//
//  Created by adol kazmy on 30/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import Firebase

class ConfirmationVC : UIViewController {
    
    
    //Outlets :
    @IBOutlet weak var orderTxtView: UITextView!
    
    
    //Variables :
    var order : OrderObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
    }
    
    func getData () {
        
        UserApi.getUser(id: order.userID!) { (userObj) in
                self.orderTxtView.text = """
                Name : \(userObj.name ?? "") \n
                Email : \(userObj.email ?? "") \n
                Age : \(userObj.age ?? 0) \n
                Phone Number : \(userObj.phoneNumber ?? "") \n
                Address : \(userObj.address ?? "") \n
                """
            
        }
    }
    
    
    
    
    
    @IBAction func editPressed(_ sender: Any) {
        // no need for this button.
    }
    
    
    
    @IBAction func donePressed(_ sender: Any) {
        order.uploadOrder()
        performSegue(withIdentifier: "toNext", sender: self)
    }
    
}


class ThankYouMsg : UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
