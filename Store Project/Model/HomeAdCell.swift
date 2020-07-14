//
//  HomeAdCell.swift
//  Store Project
//
//  Created by adol kazmy on 20/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import SDWebImage

class HomeAdCell: UICollectionViewCell {
    
    @IBOutlet weak var adImg: UIImageView!
    

    
    
    func updateImg (ad : AdObject) {
        if let strUrl = ad.imgUrl, let url = URL ( string: strUrl) {
            adImg.sd_setImage(with: url, completed: nil)
        }
        } 

}
