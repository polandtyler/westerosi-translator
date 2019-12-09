//
//  Valyrian.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

import Foundation

struct HighValyrian: WesterosiLanguage {
    var type: LanguageType = .highValyrian
    
    var testJsonResponse: String = """
        "success": {
            "total": 1
        },
        "contents": {
            "translated": "Issa brōzi iksos khali drogo",
            "text": "my name is khal drogo",
            "translation": "valyrian"
        }
    """
}
