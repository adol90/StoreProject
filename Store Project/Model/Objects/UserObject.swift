//
//  UserObject.swift
//  Store Project
//
//  Created by adol kazmy on 25/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase


class UserObject {
    
    
    var id : String?
    var name : String?
    var timeStamp : TimeInterval?
    var age : Int?
    var isMale : Bool?
    
    
    
    //this init is to be used in classes to filled the Var's with what the user want then upload it
    init(id : String ,name : String ,timeStamp : TimeInterval , age : Int , isMale : Bool)  {
        self.id = id
        self.name = name
        self.timeStamp = timeStamp
        self.age = age
        self.isMale = isMale
    }
    
    //this init is for to be filled with data send from server as AnyObject values.
    init(dictionary : [String : AnyObject]) {
        
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.timeStamp = dictionary["timeStamp"] as? TimeInterval
        self.age = dictionary["age"] as? Int
        self.isMale = dictionary["isMale"] as? Bool
    }
    
    
    //this func is for sending data values to database.
    func makeDictionary() -> [String : AnyObject] {
        var data : [String : AnyObject] = [:]
        
        data["id"] = self.id as AnyObject
        data["name"] = self.name as AnyObject
        data["timeStamp"] = self.timeStamp as AnyObject
        data["age"] = self.id as AnyObject
        data["isMale"] = self.isMale as AnyObject
        
        return data
    }
    
    func update() {
        guard let theID = self.id else {return}
        
        Firestore.firestore().collection("Users").document(theID).setData(makeDictionary())
    }
    
    
    
    //not recommended to use it in UserObject better to use this method in ProductObject to remove item not users!
//    func remove() {
//        guard let theID = self.id else {return}
//
//        Firestore.firestore().collection("Users").document(theID).delete()
//    }
     
    
}

class UserApi {
    
    static func getUser (id : String , completion : @escaping (_ user : UserObject) ->  ()) {
        
        Firestore.firestore().collection("Users").document(id).addSnapshotListener { (snapshot, error) in
            
            if let data = snapshot?.data() as [String : AnyObject]? {
                let newData = UserObject(dictionary: data)
                completion (newData) }
            
        }
    }
}
