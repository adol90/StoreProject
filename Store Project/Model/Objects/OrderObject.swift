//
//  OrderObject.swift
//  Store Project
//
//  Created by adol kazmy on 18/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import Foundation
import Firebase

class OrderObject {
    
    var id : String?
    var productIDs : [String]?
    var quantities : [Int]?
    var stamp : TimeInterval?
    var userID : String?
    
    
    init(id : String, productIDs : [String],quantities : [Int], stamp : TimeInterval, userID : String) {
        self.id = id
        self.productIDs = productIDs
        self.stamp = stamp
        self.userID = userID
        self.quantities = quantities
    }
    
    init(dictionary : [String : AnyObject]) {
        self.id = dictionary["id"] as? String
        self.productIDs = dictionary["productIDs"] as? [String]
        self.stamp = dictionary["stamp"] as? TimeInterval
        self.userID = dictionary["userID"] as? String
        self.quantities = dictionary["quantities"] as? [Int]
    }
    
    func makeDictionary() -> [String : AnyObject] {
        
        var dic : [String : AnyObject] = [:]
        dic["id"] = self.id as AnyObject
        dic["productIDs"] = self.productIDs as AnyObject
        dic["stamp"] = self.stamp as AnyObject
        dic["userID"] = self.userID as AnyObject
        dic["quantities"] = self.quantities as AnyObject
        return dic
    }
    
    func uploadOrder() {
        guard let id = self.id else {return}
        Firestore.firestore().collection("Orders").document(id).setData(makeDictionary())
    }
    
    func removeOrder() {
      guard let id = self.id else {return}
        Firestore.firestore().collection("Orders").document(id).delete()
    }
    
    
    
    
    
    
    
}










