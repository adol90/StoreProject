//
//  ProductDetailsVC.swift
//  Store Project
//
//  Created by adol kazmy on 11/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit



class ProductDetailsVC : UIViewController {
    
    //Outlets :
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productCView: UICollectionView! {
        didSet {
            productCView.delegate = self
            productCView.dataSource = self
            productCView.register(UINib(nibName: "ImageCView", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var decreaseBtn: UIButton!
    @IBOutlet weak var increaseBtn: UIButton!
    
    
    //Variables :
    var product : ProductObject!
    var counter = 1
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLbl.text = product.name
        self.descriptionLbl.text = product.description
        self.counterLbl.text = "1"
        self.priceLbl.text = (product.price?.description ?? "0.0") + "ريال"
    }
    
    func checkBaby() {
        if counter <= 1 {
            decreaseBtn.isEnabled = false
        } else {decreaseBtn.isEnabled = true}
         if counter == 10 {
            increaseBtn.isEnabled = false
        } else {
            increaseBtn.isEnabled = true
        }
    }
    
    @IBAction func decreasePressed(_ sender: Any) {
        counter -= 1
        counterLbl.text = counter.description
        checkBaby()
    }
    @IBAction func increasePressed(_ sender: Any) {
       
        counter += 1
        counterLbl.text = counter.description
        checkBaby()
    }
    @IBAction func orderPressed(_ sender: Any) {
        CartManager.add(product: product, quantity: counter)
    }
    
    
    
    
}
extension ProductDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.product.imgUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCView
        if let imgs = product.imgUrls {
            cell.update(url: imgs[indexPath.row])}
        
     return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = collectionView.frame.size.width
        let h = collectionView.frame.size.height
        
        return CGSize(width: w, height: h)
    }
    
    
    
    
    
}
