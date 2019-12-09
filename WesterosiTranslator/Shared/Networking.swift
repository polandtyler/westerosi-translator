//
//  Networking.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

public typealias Handler<T> = (Result<T, NetworkError>) -> Void

public struct NetworkRequest {
    public typealias NetworkingCompletion = (Response) -> Void
    
    let endpoint: Endpoint
    let queryParameters: [String: String]?
    
    public init(endpoint: Endpoint, queryParameters: [String: String]? = nil) {
           self.endpoint = endpoint
           self.queryParameters = queryParameters
       }
    
    public func performRequest(completion: @escaping NetworkingCompletion) {
        guard let finalUrl = URL(string: "\(self.endpoint.baseUrl.value)\(endpoint.path)") else {
            return
        }
        let headers: [String: String] = [
            "x-rapidapi-host": "dothraki.p.rapidapi.com",
            "x-rapidapi-key": "FNxnESxKYUmshhbFtXsmndVi4SWJp10hNE5jsnDKPggDGngZub"
        ]
        let request = URLRequest.request(url: finalUrl, method: endpoint.method.value, queryParameters: queryParameters, headers: headers)
        let task = URLSession.customSession.dataTask(with: request) { data, response, sessionError in
            var error = sessionError
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
                    let description = "HTTP response was \(httpResponse.statusCode)"
                    error = NSError(domain: "Custom", code: 0, userInfo: [NSLocalizedDescriptionKey: description])
                }
            }
            let wrappedResponse = Response(data: data, response: response, error: error)
            completion(wrappedResponse)
        }
        task.resume()
    }
}

public struct Response {
    public let data: Data?
    public let response: URLResponse?
    public var error: Error?
    
    public func isStatusCode(equalTo statusCode: Int) -> Bool {
        
        guard let responseStatusCode = (response as? HTTPURLResponse)?.statusCode else {
            return false
        }
        return responseStatusCode == statusCode
    }
    public func isStatusCode(within from: Int, and to: Int) -> Bool {
        guard let responseStatusCode = (response as? HTTPURLResponse)?.statusCode else {
            return false
        }
        return responseStatusCode >= from && responseStatusCode < to
    }
    public func isSuccessfulStatus() -> Bool {
        return isStatusCode(within: 200, and: 300)
    }
    
    public var HTTPResponse: HTTPURLResponse? {
        return response as? HTTPURLResponse
    }
    public var responseJSON: Any? {
        if let data = data {
            return try? JSONSerialization.jsonObject(with: data, options: [])
        } else {
            return nil
        }
    }
    public var responseString: String? {
        if let data = data, let string = String(data: data, encoding: .utf8) {
            return string
        } else {
            return nil
        }
    }
}
