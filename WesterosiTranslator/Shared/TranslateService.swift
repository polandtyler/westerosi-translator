//
//  TranslateService.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

struct TranslateService {
    public func translateRequest(with text: String, language: LanguageType, completion: @escaping (Handler<Translation>)) {
        let queryParams = ["text": text]
        let endpoint = language == .dothraki ? TranslateEndpoint.postDothraki : TranslateEndpoint.postHighValyrian
        let request = NetworkRequest(endpoint: endpoint, queryParameters: queryParams)
        request.performRequest { (response) in
            let result = ResultBuilder.buildResult(type: Translation.self, response: response)
            completion(result)
        }
    }
}


