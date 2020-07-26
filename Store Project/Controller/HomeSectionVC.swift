//
//  HomeSectionVC.swift
//  Store Project
//
//  Created by fatma on 05/12/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//


import UIKit

extension HomeSectionVC {
    
    func setUpRefresher () {
        refreshControler.addTarget(self, action: #selector(refreshNow), for: .valueChanged)
        refreshControler.tintColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.9820205479)
        tableView.addSubview(refreshControler)
    }
    
    @objc func refreshNow() {
        sections = []
        tableView.reloadData()
        getSections()
        refreshControler.endRefreshing()
        
    }
    
}

class HomeSectionVC : UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "SectionTViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    var sections : [SectionObject] = []
    var selectedSection : SectionObject?
    var refreshControler : UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSections()
        setUpRefresher()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("reloadData"), object: nil)
        
    }
    
    @objc func reloadData() {
        sections = []
        tableView.reloadData()
        getSections()
    }
    func getSections() {
        SectionApi.getAllSections { (section : SectionObject) in
            self.sections.append(section)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}
extension HomeSectionVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SectionTViewCell
        cell.update(section: sections[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.size.height / 3) - 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toProducts", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProductsInSectionVC {
            if let indexP = sender as? Int {
                destinationVC.inSection = sections[indexP]
            }
            
        }
    }
}




