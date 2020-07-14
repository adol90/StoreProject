//
//  UploadExtension.swift
//  Store Project
//
//  Created by adol kazmy on 10/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import Foundation
import Firebase


class UploadExtension {
    
    static func uploadImg(image : UIImage , completion : @escaping (_ url : String) -> ()) {
        
        
        guard let dataImg = image.pngData() else {return}
        
        let storage = Storage.storage().reference()
        let imgRef = storage.child("images").child(UUID().uuidString)
        imgRef.putData(dataImg, metadata: nil) { (meta, error) in
            if error != nil {return}
            
            imgRef.downloadURL { (url, error) in
                if error != nil {return}
                guard let strUrl = url?.absoluteString else {return}
                completion(strUrl)
            }
        }
    }
}
extension UIImage {
    
    func upload(completion : @escaping (_ url : String)-> ()) {
        UploadExtension.uploadImg(image : self.resizeImg(image: self, targetSize: CGSize(width: 500, height: 500))) { (Url) in completion(Url)}
    }
    func resizeImg(image : UIImage , targetSize : CGSize)->UIImage {
        let size = image.size
        
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize : CGSize
        if (widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return newImg!
    }
    
}






