//
//  HomeVC.swift
//  
//
//  Created by adol kazmy on 20/06/2020.
//

import UIKit
import SDWebImage
import Firebase



class HomeVC : UIViewController {
    
    @IBOutlet weak var homeAdCView: UICollectionView!
    @IBOutlet weak var latestCView: UICollectionView!
    @IBOutlet weak var offersCView: UICollectionView!
    
    //Outlets :
    var adArray : [AdObject] = []
    
    var latestProductsArray : [ProductObject] = []
    var offersArray : [ProductObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        setUpCell()
        getProducts()
        startTimer()
        getLanguage()
        
    }
    
    
    func getProducts() {
        
        AdsApi.getAllAds { (ad) in
            self.adArray.append(ad)
            self.homeAdCView.reloadData()
        }
        
        ProductApi.getAllProducts(sectionID: "") { (product) in
            self.latestProductsArray.append(product)
            self.latestCView.reloadData()
        }
           
//            ProductApi.getAllProducts() { (product) in
//            self.offersArray.append(product)
//            self.offersCView.reloadData() }
        
    }
    
    


    
}

extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath ) -> CGSize {
        
        
        if collectionView.tag == 0 {
         
            let width = self.view.frame.size.width
            let height = self.view.frame.size.height - self.view.alignmentRectInsets.bottom - self.view.alignmentRectInsets.top
            return CGSize(width: width , height: height) }
        
        if collectionView.tag == 1 || collectionView.tag == 2 {
            
            let width = collectionView.frame.size.height / 1.7
            let height = collectionView.frame.size.height
            
            return CGSize(width: width , height: height) }
        
        return CGSize(width: 100 , height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func setUpCell () {
        
     
        
        homeAdCView.register(UINib(nibName: "HomeAdCell" , bundle: nil), forCellWithReuseIdentifier: "homeCell")
        homeAdCView.delegate = self
        homeAdCView.dataSource = self
        
        // second CView
        latestCView.register(UINib(nibName: "LatestProductCell" , bundle: nil), forCellWithReuseIdentifier: "latestCell")
        latestCView.delegate = self
        latestCView.dataSource = self
        
        // third CView
        offersCView.register(UINib(nibName: "OffersCell" , bundle: nil), forCellWithReuseIdentifier: "offersCell")
        offersCView.delegate = self
        offersCView.dataSource = self
        
        
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        if collectionView.tag == 0 {
            return adArray.count }
        if collectionView.tag == 1 {
            return latestProductsArray.count }
        if collectionView.tag == 2 {
            return offersArray.count }
        
     
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        if collectionView.tag == 0 {
        let cell = homeAdCView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeAdCell
            
            
            cell.updateImg(ad: adArray[indexPath.row])
            
            return cell
        }
        
        if collectionView.tag == 1 {
            let cell = latestCView.dequeueReusableCell(withReuseIdentifier: "latestCell", for: indexPath) as! LatestProductCell
            
            cell.update(product: latestProductsArray[indexPath.row])
            
            return cell
            
        }
        if collectionView.tag == 2 {
            let cell = offersCView.dequeueReusableCell(withReuseIdentifier: "offersCell", for: indexPath) as! OffersCell
            
            cell.update(product: offersArray[indexPath.row])
            
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
    
    
    func startTimer() {

        let timer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
    }


    @objc func scrollAutomatically(_ timer1: Timer) {

        if let AdCollection  = homeAdCView {
            for cell in AdCollection.visibleCells {
                let indexPath: IndexPath? = AdCollection.indexPath(for: cell)
                if ((indexPath?.row)! < adArray.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)

                    AdCollection.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    AdCollection.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }

            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            ProductApi.getProduct(id: adArray[indexPath.row].id!) { (product) in
                self.performSegue(withIdentifier: "toDetails", sender: product)
            } }
       else if collectionView.tag == 1 {
            self.performSegue(withIdentifier: "toDetails", sender: self.latestProductsArray[indexPath.row]) }
        else if collectionView.tag == 2 {
            self.performSegue(withIdentifier: "toDetails", sender: self.offersArray[indexPath.row]) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProductDetailsVC {
            guard let product = sender as? ProductObject else {return}
            destinationVC.product = product
        }
    }
    
    
}
