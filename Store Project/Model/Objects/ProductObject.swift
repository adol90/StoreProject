//
//  ProductObject.swift
//  Store Project
//
//  Created by adol kazmy on 25/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase


class ProductObject {
    
    
    var id : String?
    var name : String?
    var imgUrls : [String]?
    var timeStamp : TimeInterval?
    var company : String?
    var price : Double?
    var description : String?
    
    
    
    //this init is to be used in classes to filled the Var's with what the user want then upload it
    init(id : String ,name : String , imgUrls : [String] ,timeStamp : TimeInterval , company : String , price : Double , description : String)  {
        self.id = id
        self.name = name
        self.imgUrls = imgUrls
        self.timeStamp = timeStamp
        self.company = company
        self.price = price
        self.description = description
    }
    
    //this init is for to be filled with data send from server as AnyObject values.
    init(dictionary : [String : AnyObject]) {
        
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.imgUrls = dictionary["imgUrls"] as? [String]
        self.timeStamp = dictionary["timeStamp"] as? TimeInterval
        self.company = dictionary["company"] as? String
        self.price = dictionary["price"] as? Double
        self.description = dictionary["description"] as? String
    }
    
    
    //this func is for sending data values to database.
    func makeDictionary() -> [String : AnyObject] {
        var data : [String : AnyObject] = [:]
        
        data["id"] = self.id as AnyObject
        data["name"] = self.name as AnyObject
        data["imgUrls"] = self.imgUrls as AnyObject
        data["timeStamp"] = self.timeStamp as AnyObject
        data["company"] = self.company as AnyObject
        data["price"] = self.price as AnyObject
        data["description"] = self.description as AnyObject
        
        return data
    }
    
    func upload() {
        guard let theID = self.id else {return}
        Firestore.firestore().collection("Products").document(theID).setData(makeDictionary())
    }
    
    
    
    
    
    //not recommended to use it in UserObject better to use this method in ProductObject to remove item not users!
    func remove() {
        guard let theID = self.id else {return}
        Firestore.firestore().collection("Products").document(theID).delete()
        Firestore.firestore().collection("Ads").document(theID).delete()
    }
     
    
}

class ProductApi {
    
    static func getProduct ( id : String , completion : @escaping (_ product : ProductObject) ->  ()) {
        
        Firestore.firestore().collection("Products").document(id).addSnapshotListener { (snapshot, error) in
            
            if let data = snapshot?.data() as [String : AnyObject]? {
                let newData = ProductObject(dictionary: data)
                completion (newData) }
            
        }
    }
    
    static func getAllProducts (  completion : @escaping (_ product : ProductObject) ->  ()) {
           
    
        Firestore.firestore().collection("Products").addSnapshotListener { (query, error) in
            if error != nil {return}
            guard let doucments = query?.documents else {return}
            for doc in doucments {
                if let data = doc.data() as [String: AnyObject]? {
                    let newData = ProductObject(dictionary: data)
                    completion (newData)
                }
            }
        }
        
        
        
        
        
//           Firestore.firestore().collection("Products").getDocuments { (query, error) in
//                   if error != nil {return}
//                       guard let doucments = query?.documents else {return}
//
//                       for doucument in doucments {
//                           if let data = doucument.data() as [String : AnyObject]? {
//                               let newData = ProductObject(dictionary: data)
//                               completion (newData)
//                       }
//                   }
//               }
    }
}
