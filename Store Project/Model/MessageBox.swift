//
//  MessageBox.swift
//  Store Project
//
//  Created by fatma on 30/11/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//


import UIKit


class MessageBoxVC : UIViewController {
    
    var theText : String?
    @IBOutlet weak var errorTxtLbl: UILabel!
    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTxtLbl.text = theText
    }
    
}
class MessageBox  {
    
    static func show(text: String) {
        let storyBoard = UIStoryboard(name: "MessageBox", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "MessageBox") as! MessageBoxVC
        vc.theText = text
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        UIApplication.getPresentedVC()?.present(vc, animated: true, completion: nil)
    }
}

extension UIApplication {
    
    
    static func getPresentedVC() -> UIViewController? {
//        var presentedVC = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
         var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        return presentedVC
    }
    
}
