//
//  TranslateEndpoint.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

struct TranslateEndpoint {
    static var postDothraki = Endpoint(path: "/dothraki.json", method: .POST, baseUrl: .funTranslations)
    static var postHighValyrian = Endpoint(path: "/valyrian.json", method: .POST, baseUrl: .funTranslations)
}

public struct Endpoint {
    public let path: String
    public let method: Method
    public let baseUrl: BaseUrl
}

public enum Method: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
    
    public var value: String {
        return self.rawValue
    }
}

public enum BaseUrl: String {
    case funTranslations = "https://api.funtranslations.com/translate"
    
    public var value: URL {
        return URL(string: self.rawValue)!
    }
}
