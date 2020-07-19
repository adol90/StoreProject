//
//  LanguageDetector.swift
//  Store Project
//
//  Created by adol kazmy on 18/07/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import Foundation

enum languages {
    case arabic
    case english
}

func getLanguage() -> languages {
    let preferedLanguage = Locale.preferredLanguages[0] as String
    let lang = preferedLanguage.split(separator: "-")
    if lang[0] == "ar" {return .arabic}
    else {return.english}
}

