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
    @IBOutlet weak var editedView: UIView!{
        didSet { editedView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3011558219) ; editedView.layer.borderWidth = 0.8 }
    }
    @IBOutlet weak var quntityLbl: UILabel!
    

    func update(product : ProductObject) {
       
        productNameLbl.text = product.name
        quntityLbl.text = product.quantity?.description
        
        //to convert a double to String we use .d
     
     priceLbl.text = product.price!.description + "ريال"
     
     guard let imgString = product.imgUrls?[0] , let url = URL(string: imgString) else {return}
     
     productImg.sd_setImage(with: url , completed: nil)
       
    }
    

}
