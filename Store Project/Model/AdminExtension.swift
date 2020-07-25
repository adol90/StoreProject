//
//  AdminExtension.swift
//  Store Project
//
//  Created by fatma on 30/11/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//

import Foundation
import FirebaseDatabase

class AdminExtension {
    
    static func isAdmin(completion : @escaping ()-> ()) {
        
        Database.database().reference().child("AdminCanRead").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                completion()
            }
             
        })
        
    }
}
