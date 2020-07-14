//
//  ImageCView.swift
//  Store Project
//
//  Created by adol kazmy on 13/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCView: UICollectionViewCell {
    
    @IBOutlet weak var imgCView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func update (url : String) {
       guard let Url = URL(string: url) else {return}
        self.imgCView?.sd_setImage(with: Url, completed: nil)
    }
    
    func update (img : UIImage) {
        self.imgCView.image = img
    }
}
