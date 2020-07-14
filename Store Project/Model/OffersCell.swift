//
//  OffersCell.swift
//  Store Project
//
//  Created by adol kazmy on 23/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import SDWebImage

class OffersCell: UICollectionViewCell {

    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var priceBeforeLbl: UILabel!
    @IBOutlet weak var priceAfterCell: UILabel!
    @IBOutlet weak var offerImg: UIImageView!
    

    func update(product : ProductObject) {
       
        productNameLbl.text = product.name
        priceAfterCell.text = product.price!.description + " ريال"
        
        guard let imgString = product.imgUrls?[0] , let url = URL(string: imgString) else {return}
        
        offerImg.sd_setImage(with: url , completed: nil)
        
        
       
        
        let attributedText : NSMutableAttributedString =  NSMutableAttributedString(string: product.price!.description )
        attributedText.addAttributes([
                        NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                        NSAttributedString.Key.strikethroughColor: UIColor.lightGray,
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)
                        ], range: NSMakeRange(0, attributedText.length))
        
        //to convert a double to String we use .d
        priceBeforeLbl.attributedText = attributedText
       
    }
    
}
