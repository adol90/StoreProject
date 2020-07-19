//
//  CartCell.swift
//  Store Project
//
//  Created by adol kazmy on 19/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import SDWebImage


class CartCell: UITableViewCell {

    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
     @IBOutlet weak var productImg: UIImageView!
     

    func update(product : ProductObject) {
       
        productNameLbl.text = product.name
        
        //to convert a double to String we use .d
     
     priceLbl.text = product.price!.description + "ريال"
     
     guard let imgString = product.imgUrls?[0] , let url = URL(string: imgString) else {return}
     
     productImg.sd_setImage(with: url , completed: nil)
       
    }
    

}
