//
//  Translation.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

struct Translation : Decodable {
    let contents: TranslationContents
    let translatedText: String
    
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contents = try container.decode(TranslationContents.self, forKey: .contents)
        translatedText = contents.translated
    }
}

struct TranslationContents : Decodable {
    let translated: String
    let text: String
    let translation: String
    
    enum CodingKeys: String, CodingKey {
        case translated = "translated"
        case text = "text"
        case translation = "translation"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.translated = try container.decode(String.self, forKey: .translated)
        self.text = try container.decode(String.self, forKey: .text)
        self.translation = try container.decode(String.self, forKey: .translation)
    }
}
