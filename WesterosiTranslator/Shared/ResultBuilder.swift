//
//  ResultBuilder.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import Foundation

struct ResultBuilder {
    static func buildResult<T: Decodable>(type: T.Type, response: Response) -> Result<T, NetworkError> {
        if let error = buildError(response: response) {
            return .failure(.error(error))
        }
        do {
            guard let data = response.data else {
                return .failure(.error("Something went wrong. No data received."))
            }
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.error("Something went wrong in the app"))
        }
    }

    static func buildError(response: Response) -> String? {
        guard response.isSuccessfulStatus() else {
            if response.responseJSON == nil {
                return "Unable to connect to server"
            }
            if let json = response.responseJSON as? [String: Any], let error = json["error"] as? String {
                return "\(error) (\(response.HTTPResponse?.statusCode ?? 0))"
            }
            return "Something went wrong: (\(response.HTTPResponse?.statusCode ?? 0))"
        }
        return nil
    }
}

public enum NetworkError: Error {
    case error(String)

    public var displayable: String {
        if case .error(let value) = self {
            return value
        }
        return ""
    }
}
