//
//  SectionTViewCell.swift
//  Store Project
//
//  Created by fatma on 03/12/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//

import UIKit
import SDWebImage

class SectionTViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionImg: UIImageView!
    @IBOutlet weak var sectionName: UILabel!
    
    
    func update(section : SectionObject) {
        
        sectionName.text = section.name
        guard let imgString = section.imgUrl, let url = URL(string: imgString) else {return}
        sectionImg.sd_setImage(with: url , completed: nil)
    }
}
