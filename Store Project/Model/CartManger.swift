//
//  CartManger.swift
//  Store Project
//
//  Created by adol kazmy on 19/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import Foundation


class CartManager {
    
    static func extractInfo(str : String) -> (id : String , Quantity : Int){
        let arr = str.components(separatedBy: "|")
        return (arr[0], Int(arr[1])!)
    }
    
    static func add(product : ProductObject, quantity : Int) {
        // new way :
        
        if let data = UserDefaults.standard.array(forKey: "cart") {
            var theData = data
            var isNew = true
            for (index,one) in (data as! [String]).enumerated() {
                if product.id! == extractInfo(str: one).id {
                    theData.remove(at: index)
                    theData.insert((product.id! + "|" + quantity.description), at: index)
                    UserDefaults.standard.set(theData, forKey: "cart")
                    isNew = false
                }
            }
            if isNew == true {
                theData.append(product.id! + "|" + quantity.description)
                UserDefaults.standard.set(theData, forKey: "cart")
            } else {
                UserDefaults.standard.set([(product.id! + "|" + quantity.description)], forKey: "cart")
            }
            
        }
            
            // old way :
            //        if let data = UserDefaults.standard.array(forKey: "cart") {
            //            var isNew = true
            //            var theData = data
            //            for one in data as! [String]{
            //                if product.id == extractInfo(str: one).id {
            //
            //                }
            //            }
            //
            //                theData.append(product.id! + "|" + quantity.description)
            //                UserDefaults.standard.set(theData, forKey: "cart")
            //        }
        else { UserDefaults.standard.set([(product.id! + "|" + quantity.description)], forKey: "cart")
        }
    }
    
    static func remove(product : ProductObject) {
        
        if let data = UserDefaults.standard.array(forKey: "cart") {
            var theData = data
            for (index,one) in theData.enumerated() {
                if product.id! == extractInfo(str: one as! String).id {
                    theData.remove(at: index)
                }
            }
            UserDefaults.standard.set(theData, forKey: "cart")
        }
    }
    
    
    static func getAll(completion : @escaping (_ product : ProductObject) -> ()) {
        
        if let data = UserDefaults.standard.array(forKey: "cart") {
            for one in data as! [String]  {
                ProductApi.getProduct(id: extractInfo(str: one).id) { (pro) in
                    let p = pro
                    p.quantity = extractInfo(str: one).Quantity
                    completion (pro)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

