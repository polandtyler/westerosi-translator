//
//  WesterosiLanguage.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

protocol WesterosiLanguage {
    var type: LanguageType { get set }
    var testJsonResponse: String { get }
}

enum LanguageType {
    case dothraki, highValyrian
    
    var readableString : String {
        switch self {
        case .dothraki:
            return "Dothraki"
        case .highValyrian:
            return "Valyrian"
        }
    }
}
