//
//  URLSession+Exts.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation
extension URLRequest {

    static func request(url: URL, method: String, queryParameters: [String: String]?, headers: [String: String]?) -> URLRequest {
        let actualURL: URL
        if let queryParameters = queryParameters {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = queryParameters.map({ (key, value) in URLQueryItem(name: key, value: value)})
            actualURL = components.url!
        } else {
            actualURL = url
        }
        var request = URLRequest(url: actualURL)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (field, value) in headers {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }

        return request
    }
}

extension URLSession {
    
    class var customSession: URLSession {
        struct Instance {
            static let session = URLSession(configuration: URLSessionConfiguration.default, delegate: SessionDelegate(), delegateQueue: OperationQueue.main)
            
        }
        return Instance.session
    }
}

extension URLSessionConfiguration {
    
    class func customConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.httpShouldUsePipelining = true
        config.requestCachePolicy = .reloadRevalidatingCacheData
        return config
    }
}

class SessionDelegate: NSObject, URLSessionDelegate {
}
