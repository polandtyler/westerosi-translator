//
//  Dothraki.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

struct Dothraki: WesterosiLanguage {
    var type: LanguageType = .dothraki
    
    var testJsonResponse: String = """
        "success": {
            "total": 1
        },
        "contents": {
            "translated": "Tih hake is khal drogo",
            "text": "my name is khal drogo",
            "translation": "dothraki"
        }
    """
}
