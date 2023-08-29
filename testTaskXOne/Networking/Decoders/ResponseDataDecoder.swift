//
//  ResponseDataDecoder.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

public final class ResponseErrorDecoder {
    public init() {}
    
    public func decode(response: HTTPURLResponse, data: Data) -> Swift.Error? {
        guard 200..<300 ~= response.statusCode else {
            let errorsRoot = try? JSONDecoder().decode(ResponseErrorsRoot.self, from: data)
            let errorDetail = errorsRoot?.errors.first?.detail
            return NetworkingLocalizableError(errorDatail: errorDetail)
        }
        return nil
    }
}
