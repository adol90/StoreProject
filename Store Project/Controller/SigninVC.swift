//
//  SigninVC.swift
//  Store Project
//
//  Created by adol kazmy on 17/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import Firebase


class SigninVC : UIViewController , UIScrollViewDelegate {
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingUpKeyboardNotificaions()
    }
    
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!

    
    @IBAction func signinPressed(_ sender: Any) {
        
        if emailTxt.text != nil && passwordTxt.text != nil {
            Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTxt.text!) { (auth, error) in
            
                if error != nil {
                    print("error while signing in")
//                    self.simpleAlert(title: "Error", msg: "error while trying to signing in")
                    if let err = error {
                        MessageBox.show(text: FireError.error(code: err._code)) }
                } else {
                    print("signed in successfully :D")
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            }
        } else {return}
    }
    
    
}


// Keyboard
extension SigninVC {
    
    func SettingUpKeyboardNotificaions(){
        NotificationCenter.default.addObserver(self, selector: #selector(SigninVC.KeyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SigninVC.KeyboardHid(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func KeyboardShow(notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.bottomLayout.constant =  (keyboardSize.height * -1 ) + 34
                self.view.layoutIfNeeded()
                }, completion: nil)
            
        }
        
    }
    
    @objc func KeyboardHid(notification : NSNotification) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.bottomLayout.constant = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    
}


