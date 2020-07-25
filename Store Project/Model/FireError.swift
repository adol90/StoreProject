//
//  FireError.swift
//  Store Project
//
//  Created by fatma on 30/11/1441 AH.
//  Copyright © 1441 Adel Kazme. All rights reserved.
//

import Foundation
import Firebase

class FireError {
    
    static func error (code : Int) -> String {
        if let theError = AuthErrorCode(rawValue: code) {
        switch theError {
        case .emailAlreadyInUse :
            return "هذا الايميل مستخدم بالفعل"
            case .weakPassword :
            return "كلمة السر ضعيفه للغاية"
            case .networkError :
            return "حدث خطأ، تأكد من اتصالك بالشبكة"
            case .userNotFound:
            return "نعتذر الحساب غير موجود"
            case .invalidEmail:
            return "البريد الالكتروني خاطئ"
            case .wrongPassword:
            return "كلمة المرور غير صحيحة"
        default :
            return "خطأ غير معروف"
        }
   
        }
            return "خطأ غير معروف"
    }
    
    
    
    
}
