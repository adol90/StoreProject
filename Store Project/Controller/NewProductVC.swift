//
//  NewProductVC.swift
//  Store Project
//
//  Created by adol kazmy on 28/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker
import FirebaseStorage
import SDWebImage



class NewProduct : UIViewController {
    
    
 //Outlets :
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var companyTxt: UITextField!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionPicker: UIPickerView!
    @IBOutlet weak var adImg: UIImageView!
    
    //Variables :
    let imgPicker = ImagePickerController()
    var collection = ""
    let collectionArray = ["Products", "Offers"]
    var editedProduct : ProductObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionPicker.delegate = self
        collectionPicker.dataSource = self
        
        activityIndicator.isHidden = true
        imgPicker.settings.selection.max = 1
        imgPicker.settings.theme.selectionStyle = .checked
        imgPicker.settings.selection.unselectOnReachingMax = true
        
        editingMode()
    }
    
    @IBAction func uploadImPressed(_ sender: Any) {
        
        presentImagePicker( imgPicker, select: { (phAsset) in
            
        }, deselect: { (phAsset) in
            
        }, cancel: { (phAsset) in
            
        }, finish:  { (phAsset) in
            
            if phAsset.count > 0 {
                let img = phAsset[0]
                self.productImg.image = self.getUIImage(asset: img)
            }
            

        }
    )}
    
    func editingMode() {
        if let editedP = editedProduct {
            self.nameTxt.text = editedP.name
            self.companyTxt.text = editedP.company
            self.descriptionTxtView.text = editedP.description
            self.priceTxt.text = editedP.price?.description
            let strUrl = editedP.imgUrl
            let url = URL(string: strUrl!)
            self.productImg.sd_setImage(with: url, completed: nil)
           
            
        }
    }
    
    @IBAction func uploadAdImgPressed(_ sender: Any) {
        
        presentImagePicker( imgPicker, select: { (phAsset) in
                   
               }, deselect: { (phAsset) in
                   
               }, cancel: { (phAsset) in
                   
               }, finish:  { (phAsset) in
                   
                   if phAsset.count > 0 {
                       let img = phAsset[0]
                       self.adImg.image = self.getUIImage(asset: img)
                   }
                   

               }
           )
        
    }
    
    
    @IBAction func uploadPressed(_ sender: Any) {
        
        activityIndicator.isHidden = false
        
        self.productImg.image?.upload(completion : {(imageUrl : String) in
            
                guard let price = Double(self.priceTxt.text!) else {return}
            
                var randomID : String!
                if let editingID = self.editedProduct?.id { randomID = editingID }
                else { randomID = UUID().uuidString }
            
                let newProduct = ProductObject(id: randomID, name: self.nameTxt.text!, imgUrl : imageUrl ,  timeStamp: Date().timeIntervalSince1970, company: self.companyTxt.text!, price: price, description: self.descriptionTxtView.text!)
                newProduct.upload()
            print("product has been uploaded successfully :)")
                
              })
                
        uploadAdForProduct(productID: editedProduct?.id ?? UUID().uuidString)
        print("AD has been uploaded successfully :)")
            
//              self.navigationController?.popViewController(animated: true)
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


extension NewProduct :  UIPickerViewDataSource , UIPickerViewDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return collectionArray.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return collectionArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        collection = collectionArray[row]
        print("we will upload to \(collection)")
    }
    
    func uploadAdForProduct(productID : String) {
        self.adImg.image?.upload(completion : { (imageUrl : String) in
            
          
                AdObject(id: "AD" + productID, imgUrl: imageUrl, timeStamp: Date().timeIntervalSince1970, productID: productID).upload()
                
                print("Ad Uploaded")
        })
    }
}


    

