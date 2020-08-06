//
//  CartVC.swift
//  Store Project
//
//  Created by adol kazmy on 19/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import Firebase


class CartVC : UIViewController {
    
    var products : [ProductObject] = []
    @IBOutlet weak var productCostLbl: UILabel!
    @IBOutlet weak var shippingCost: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self ; tableView.dataSource = self
            tableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    func getCart () {
        CartManager.getAll { (product) in
            self.products.append(product)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.calculatePrice()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getCart ()
        
    }
    
    
    func calculatePrice() {
        var pCost : Double = 0
        for one in products {
            pCost = pCost + (one.price ?? 0.0)
        }
        productCostLbl.text = String(pCost) + "ريال"
        shippingCost.text = String(products.count * 3) + "ريال"
        totalPriceLbl.text = String(pCost + Double(products.count * 3)) + "ريال"
        
    }
    
    
    @IBAction func ApplyOrderPressed(_ sender: Any) {
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let userID = user?.uid {
                let ids : [String] = self.products.map({ return $0.id!})
                let quantities : [Int] = self.products.map({ return $0.quantity!})
                
                let newOrder = OrderObject(id: UUID().uuidString, productIDs: ids, quantities: quantities, stamp: Date().timeIntervalSince1970, userID: userID)
                
                self.performSegue(withIdentifier: "toNext", sender: newOrder)
                
            }
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? OrderInfoVC {
            if let order = sender as? OrderObject {
                destinationVC.order = order
            }
        }
    }
    
}

extension CartVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartCell
        cell.update(product: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CartManager.remove(product: products[indexPath.row])
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            calculatePrice()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
}
