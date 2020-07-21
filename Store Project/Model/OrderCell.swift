//
//  OrderCell.swift
//  Store Project
//
//  Created by adol kazmy on 20/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import SDWebImage

class OrderCell: UICollectionViewCell {

        
       @IBOutlet weak var productNameLbl: UILabel!
       @IBOutlet weak var priceLbl: UILabel!
       @IBOutlet weak var productImg: UIImageView!
       @IBOutlet weak var quantityLbl: UILabel!
       @IBOutlet weak var decreaseOutlet: UIButton!
    
    //Variables:
    var counter = 1
    
    @IBAction func increasePressed(_ sender: Any) {
        

        counter += 1
        
               quantityLbl.text = String(counter)
    }
  
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.shadowColor = UIColor.lightGray.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//        layer.shadowRadius = 1
//        layer.shadowOpacity = 0.3
//        layer.masksToBounds = true
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
//        layer.backgroundColor = UIColor.clear.cgColor
//    }
    
    @IBAction func decreasePressed(_ sender: Any) {
//        if counter > 1 {
//            v = String(counter - 1) }
//        else {
//            self.isHidden = true
//        }
        counter -= 1
        quantityLbl.text = String(counter)
        
    }
    
//    func result (count : Int ) {
//
//        quantityLbl.text = String(count)
//        if count < 2 {decreaseOutlet.isEnabled = false
//        } else if count >= 2 { decreaseOutlet.isEnabled = true }
//    }
    
    
    func update(product : ProductObject) {
          
        productNameLbl.text = "  " + (product.name ?? "")
           
           //to convert a double to String we use .d
        
        priceLbl.text = "  " + product.price!.description + " ريال"
        
        guard let imgString = product.imgUrls?[0] , let url = URL(string: imgString) else {return}
        
        productImg.sd_setImage(with: url , completed: nil)
          
       }

}
