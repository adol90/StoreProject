//
//  AdObject.swift
//  Store Project
//
//  Created by adol kazmy on 25/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase


class AdObject {
    
    
    var id : String?
    var imgUrl : String?
    var timeStamp : TimeInterval?
    var productID : String?
    
    
    
    
    //this init is to be used in classes to filled the Var's with what the user want then upload it
    init(id : String , imgUrl : String ,timeStamp : TimeInterval , productID : String)  {
        self.id = id
        self.imgUrl = imgUrl
        self.timeStamp = timeStamp
        self.productID = productID
    }
    
    //this init is for to be filled with data send from server as AnyObject values.
    init(dictionary : [String : AnyObject]) {
        
        self.id = dictionary["id"] as? String
        self.imgUrl = dictionary["imgUrl"] as? String
        self.timeStamp = dictionary["timeStamp"] as? TimeInterval
        self.productID = dictionary["productID"] as? String
    }
    
    
    //this func is for sending data values to database.
    func makeDictionary() -> [String : AnyObject] {
        var data : [String : AnyObject] = [:]
        
        data["id"] = self.id as AnyObject
        data["imgUrl"] = self.imgUrl as AnyObject
        data["timeStamp"] = self.timeStamp as AnyObject
        data["productID"] = self.productID as AnyObject
        
        return data
    }
    
    func upload() {
        guard let theID = self.id else {return}
        Firestore.firestore().collection("Ads").document(theID).setData(makeDictionary())
    }
    
    
    
    
    
    //not recommended to use it in UserObject better to use this method in ProductObject to remove item not users!
    func remove() {
        guard let theID = self.id else {return}
        Firestore.firestore().collection("Ads").document(theID).delete()
    }
    
    
}

class AdsApi {
    
    static func getProduct ( id : String , completion : @escaping (_ ad : AdObject) ->  ()) {
        
        Firestore.firestore().collection("Ads").document(id).addSnapshotListener { (snapshot, error) in
            
            if let data = snapshot?.data() as [String : AnyObject]? {
                let newData = AdObject(dictionary: data)
                completion (newData) }
            
        }
    }
    
    static func getAllAds ( completion : @escaping (_ product : AdObject) ->  ()) {
        
        
        Firestore.firestore().collection("Ads").addSnapshotListener { (query, error) in
            if error != nil {return}
            guard let doucments = query?.documents else {return}
            for doc in doucments {
                if let data = doc.data() as [String: AnyObject]? {
                    let newData = AdObject(dictionary: data)
                    completion (newData)
                }
            }
        }
    }
}
