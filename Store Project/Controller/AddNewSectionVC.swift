//
//  AddNewSectionVC.swift
//  Store Project
//
//  Created by fatma on 03/12/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//

import UIKit
import SDWebImage
import BSImagePicker
//import Firebase
import Photos


class AddNewSectionVC : UIViewController {
    
    //Outlets :
    @IBOutlet weak var sectionNameTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sectionImg: UIImageView!
    
    //Variables :
    var imgPicker = ImagePickerController()
    var editedSetction : SectionObject?
    var newID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        imgPicker.settings.selection.max = 1
        imgPicker.settings.theme.selectionStyle = .numbered
        imgPicker.settings.selection.unselectOnReachingMax = true
    }
    @IBAction func openPhotosPressed(_ sender: Any) {
        
        imgPicker = ImagePickerController()
        imgPicker.settings.selection.max = 1
        imgPicker.settings.theme.selectionStyle = .numbered
        
        
        presentImagePicker( imgPicker, select: { (phAsset) in
            
        }, deselect: { (phAsset) in
            
        }, cancel: { (phAsset) in
            
        }, finish:  { (phAsset) in
            let img = phAsset[0]
            DispatchQueue.main.async {
                self.sectionImg.image = self.getUIImage(asset: img)
            }
        }
            
        )
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        newID = editedSetction?.id ?? UUID().uuidString
        
        self.sectionImg.image?.upload(completion: { (url) in
            SectionObject(id: self.newID!, name: self.sectionNameTxt.text ?? "", imgUrl: url, stamp: Date().timeIntervalSince1970).upload()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadSections"), object: nil, userInfo: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    @IBAction func removePressed(_ sender: Any) {
        editedSetction?.remove()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadSections"), object: nil, userInfo: nil)
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                      self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func getUIImage(asset : PHAsset) -> UIImage {
        
        var img : UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageDataAndOrientation(for: asset, options: options) { (data, _, _, _) in
            if let data = data {
                img = UIImage(data: data)
            }
            
        }
        return img ?? UIImage()
    }
    
    
    
}


