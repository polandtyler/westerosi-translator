//
//  LanguageTranslateViewModel.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

class LanguageTranslateViewModel {
    public var updateUI: (() -> Void)?
    
    internal var translationText: String? {
        didSet {
            updateUI?()
        }
    }
    
    func performTranslation(with text: String, language: LanguageType, completion: @escaping (Bool, String?) -> Void) {
        TranslateService().translateRequest(with: text, language: language) { (result) in
            switch result {
            case .success(let translation):
                self.translationText = translation.translatedText
                completion(true, nil)
            case .failure(let error):
                print(error)
                completion(false, error.displayable)
            }
        }
    }
}
