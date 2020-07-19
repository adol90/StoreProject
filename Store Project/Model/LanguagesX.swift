//
//  LanguagesX.swift
//  Store Project
//
//  Created by adol kazmy on 18/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit


class TxtFieldLAnguage : UITextField {

    @IBInspectable var arabic : String = ""  {didSet{updateLanguage()}}
    @IBInspectable var english : String = "" {didSet{updateLanguage()}}

    func updateLanguage() {

        if getLanguage() == .arabic {
            self.attributedPlaceholder =
                NSAttributedString(string: arabic, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        } else {
            self.attributedPlaceholder =
                NSAttributedString(string: english, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        }

    } }

class ButtonLanguage : UIButton {
    @IBInspectable var arabic : String = ""  {didSet{updateLanguage()}}
    @IBInspectable var english : String = "" {didSet{updateLanguage()}}

    
    func updateLanguage() {
        if getLanguage() == .arabic {
                          setTitle(self.arabic, for: .normal)
                      } else {
                          setTitle(self.english, for: .normal)
                      }
    }
}

class LableLanguage : UILabel {
    @IBInspectable var arabic : String = ""  {didSet{updateLanguage()}}
    @IBInspectable var english : String = "" {didSet{updateLanguage()}}

    func updateLanguage() {

        if getLanguage() == .arabic {
            self.text = arabic
        } else {
            self.text = english
        }

    }
}


















