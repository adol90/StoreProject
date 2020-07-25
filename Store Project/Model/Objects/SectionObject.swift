//
//  SectionObject.swift
//  Store Project
//
//  Created by fatma on 01/12/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//

import Foundation
import Firebase

class SectionObject {
    
    var id : String?
    var name : String?
    var imgUrl : String?
    var stamp : TimeInterval?
    
    // to know when the cell is selected :
    var isCellSelected : Bool = false
    
    init(id : String , name : String , imgUrl : String , stamp : TimeInterval) {
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
        self.stamp = stamp
        
    }
        init(dictionary : [String : AnyObject] ) {
            self.id = dictionary["id"] as? String
            self.name = dictionary["name"] as? String
            self.imgUrl = dictionary["imgUrl"] as? String
            self.stamp = dictionary["stamp"] as? TimeInterval
            
        }
        
        
    func getDictionary()-> [String : AnyObject] {
        var dic : [String: AnyObject] = [:]
        dic["id"] = self.id as AnyObject
        dic["name"] = self.name as AnyObject
        dic["imgUrl"] = self.imgUrl as AnyObject
        dic["stamp"] = self.stamp as AnyObject
        
        return dic
    }
    
    func upload() {
        guard let id = self.id else {return}
        Firestore.firestore().collection("Sections").document(id).setData(getDictionary())
    }
    
    
    func remove() {
        guard let id = self.id else {return}
        Firestore.firestore().collection("Sections").document(id).delete()
    }
    
    
}



class SectionApi {
    
    
     static func getSection ( id : String , completion : @escaping (_ section : SectionObject) ->  ()) {
            
            Firestore.firestore().collection("Sections").document(id).addSnapshotListener { (snapshot, error) in
                
                if let data = snapshot?.data() as [String : AnyObject]? {
                    let newData = SectionObject(dictionary: data)
                    completion (newData) }
                
            }
        }
        
        static func getAllSections (  completion : @escaping (_ section : SectionObject) ->  ()) {
               
        
            Firestore.firestore().collection("Sections").addSnapshotListener { (query, error) in
                if error != nil {return}
                guard let doucments = query?.documents else {return}
                for doc in doucments {
                    if let data = doc.data() as [String: AnyObject]? {
                        let newData = SectionObject(dictionary: data)
                        completion (newData)
                    }
                }
            }
        }
    
    
}








