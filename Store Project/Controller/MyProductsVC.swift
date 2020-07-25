//
//  MyProductsVC.swift
//  Store Project
//
//  Created by adol kazmy on 09/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit


extension MyProductsVC {
    
    func setUpRefresher () {
        refreshControler.addTarget(self, action: #selector(refreshNow), for: .valueChanged)
        refreshControler.tintColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.9820205479)
        productCView.addSubview(refreshControler)
    }
    
    @objc func refreshNow() {
        products = []
        productCView.reloadData()
        getProducts()
        refreshControler.endRefreshing()
        
    }
    
}


class MyProductsVC : UIViewController {
    
    //Outlets :
    @IBOutlet weak var productCView: UICollectionView!
    
    
    //Variables :
    var products : [ProductObject] = []
    var selectedProduct : ProductObject?
    var refreshControler : UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCView.register(UINib(nibName: "LatestProductCell" , bundle: nil), forCellWithReuseIdentifier: "latestCell")
        productCView.delegate = self
        productCView.dataSource = self
        
        getProducts()
        setUpRefresher()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("reloadData"), object: nil)
        
       
    }
    
    @objc func reloadData() {
        products = []
        productCView.reloadData()
        getProducts()
        
    }
    
    
}
extension MyProductsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
     func getProducts() {
         
         
         ProductApi.getAllProducts() { (product) in
             
             self.products.append(product)
             self.productCView.reloadData()
             
         }
    
     }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = productCView.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath) as! LatestProductCell
        
        cell.update(product: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = productCView.bounds.size.width
        
        return CGSize(width: w * 0.33, height: w * 0.55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = products[indexPath.row]
       
        performSegue(withIdentifier: "toAddNew", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if let destinationVC = segue.destination as? NewProduct {
            destinationVC.editedProduct = selectedProduct
        }
    }
}
        
        
    
    
    


