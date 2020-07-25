//
//  SelectSectionVC.swift
//  Store Project
//
//  Created by fatma on 04/12/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//

import UIKit

protocol SelectSectionDelegate {
    func selectedSection(section : SectionObject)
}

class SelectSectionVC : UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var sections : [SectionObject] = []
    var selectedSection : SectionObject?
    var delegate : SelectSectionDelegate!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self ; tableView.dataSource = self
            tableView.register(UINib(nibName: "SectionTViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            tableView.layer.cornerRadius = 12 ; tableView.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            tableView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 12
            containerView.layer.borderColor = UIColor.white.cgColor
            containerView.layer.borderWidth = 1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllSections()
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
        if let fullSection = selectedSection {
            delegate.selectedSection(section: fullSection)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SectionTViewCell
        
        if sections[indexPath.row].id == selectedSection?.id {
            cell.sectionName.backgroundColor = UIColor.blue
            cell.sectionName.textColor = UIColor.white
        } else {
            cell.sectionName.backgroundColor = UIColor.white
            cell.sectionName.textColor = UIColor.black
        }
        
        cell.sectionName.text = sections[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
                 sections[indexPath.row].isCellSelected = true
                 selectedSection = sections[indexPath.row]
                 self.tableView.reloadData()
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func getAllSections() {
        SectionApi.getAllSections { (section) in
            self.sections.append(section)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
