//
//  CartManger.swift
//  Store Project
//
//  Created by adol kazmy on 19/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import Foundation


class CartManager {
    
    static func add(product : ProductObject) {
        
        if let data = UserDefaults.standard.array(forKey: "cart") {
            var exists : Bool = false
            var theData = data
            for one in data as! [String]{
                if product.id == one {
                    exists = true
                }
            }
            if exists == false {
                theData.append(product.id!)
                UserDefaults.standard.set(theData, forKey: "cart") }
        }
        else { UserDefaults.standard.set([product.id!], forKey: "cart")
        }
    }
    
    static func remove(product : ProductObject) {
        
        if let data = UserDefaults.standard.array(forKey: "cart") {
            var theData = data
            for (index,one) in theData.enumerated() {
                if product.id! == one as? String {
                    theData.remove(at: index)
                }
            }
            UserDefaults.standard.set(theData, forKey: "cart")
        }
    }
    
    
    static func getAll(completion : @escaping (_ product : ProductObject) -> ()) {
        
        if let data = UserDefaults.standard.array(forKey: "cart") {
            for one in data as? [String] ?? [] {
                ProductApi.getProduct(id: one) { (pro) in
                    completion (pro)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

