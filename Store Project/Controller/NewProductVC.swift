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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionPicker: UIPickerView!
    @IBOutlet weak var adImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self ; collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ImageCView", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    
    
    //Variables :
    var imgPicker = ImagePickerController()
    var collection = ""
    let collectionArray = ["Products", "Offers"]
    var editedProduct : ProductObject?
    var imgs : [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionPicker.delegate = self
        collectionPicker.dataSource = self
        
        activityIndicator.isHidden = true
        imgPicker.settings.selection.max = 5
        imgPicker.settings.theme.selectionStyle = .numbered
        imgPicker.settings.selection.unselectOnReachingMax = true
        
        editingMode()
    }
    
    @IBAction func uploadImPressed(_ sender: Any) {
        
        
        imgPicker = ImagePickerController()
        imgPicker.settings.selection.max = 5
        imgPicker.settings.theme.selectionStyle = .numbered
        
        
        presentImagePicker( imgPicker, select: { (phAsset) in
            
        }, deselect: { (phAsset) in
            
        }, cancel: { (phAsset) in
            
        }, finish:  { (phAsset) in
            
            for one in phAsset {
                
                    self.imgs.append(self.getUIImage(asset: one))
            }
            self.collectionView.reloadData()
        }
            
    )}
    
    func editingMode() {
        
        let cell = ImageCView()
        
        if let editedP = editedProduct {
            self.nameTxt.text = editedP.name
            self.companyTxt.text = editedP.company
            self.descriptionTxtView.text = editedP.description
            self.priceTxt.text = editedP.price?.description
            
            guard let strUrls = editedP.imgUrls else { return }
            for one in strUrls {
                var urlsArray = [URL]()
                urlsArray.append(URL(string: one) ?? URL(string: "no link")!)
                cell.update(url: one)
            }
       
            
        }
    }
    
    
    func uploadManyImgs( completion : @escaping (_ urls : [String]) -> ()) {
        var uploadedImgs : [String] = []
        for img in self.imgs {

            img.upload(completion: { (url) in
                uploadedImgs.append(url)
                if self.imgs.count == uploadedImgs.count {
                    completion(uploadedImgs)
                }
            })

        }
    }

    
    @IBAction func uploadAdImgPressed(_ sender: Any) {
        
        imgPicker = ImagePickerController()
        imgPicker.settings.selection.max = 5
        imgPicker.settings.theme.selectionStyle = .numbered
        
        
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
        
        self.uploadManyImgs { (urls : [String]) in
            
        

                guard let price = Double(self.priceTxt.text!) else {return}

                var randomID : String!
                if let editingID = self.editedProduct?.id { randomID = editingID }
                else { randomID = UUID().uuidString }

                let newProduct = ProductObject(id: randomID, name: self.nameTxt.text!, imgUrls : urls ,  timeStamp: Date().timeIntervalSince1970, company: self.companyTxt.text!, price: price, description: self.descriptionTxtView.text!)
                newProduct.upload()
            print("product has been uploaded successfully :)")

              }
    
                
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


extension NewProduct :  UIPickerViewDataSource , UIPickerViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCView
        
        cell.update(img: imgs[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let h = collectionView.frame.size.height
        return CGSize(width: h, height: h )
    }
    
    
    
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


    

