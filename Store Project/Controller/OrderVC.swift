//
//  OrderVC.swift
//  Store Project
//
//  Created by adol kazmy on 20/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit


class OrderVC : UIViewController {
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet { collectionView.delegate = self ; collectionView.dataSource = self ; collectionView.register(UINib(nibName: "OrderCell", bundle: nil), forCellWithReuseIdentifier: "cell")}
    }
    
    //Variables :
    var products : [ProductObject] = []
    var theCounter = 1
    
    func getCart () {
         CartManager.getAll { (product) in
             self.products.append(product)
             DispatchQueue.main.async {
                 self.collectionView.reloadData()
             }
         }
     }
     override func viewDidLoad() {
         super.viewDidLoad()
         getCart ()
         
     }
    
    
}

extension OrderVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderCell
        theCounter = cell.counter
//        cell.result(count: theCounter)
         cell.update(product: products[indexPath.row])
       
       
        
        
//        collectionView.reloadData()
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = collectionView.frame.size.height / 1.5
        let w = (collectionView.frame.size.width / 2) - 8
        return CGSize(width: w, height: h)
    }
}
