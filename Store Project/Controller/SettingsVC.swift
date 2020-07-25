//
//  SettingsVC.swift
//  Store Project
//
//  Created by fatma on 30/11/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//

import UIKit

class SettingsVC : UIViewController {
    
    
    @IBOutlet weak var adminButton: ButtonLanguage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        AdminExtension.isAdmin {
            DispatchQueue.main.async {
                self.adminButton.isHidden = false
            }
        }
    }
}
 
