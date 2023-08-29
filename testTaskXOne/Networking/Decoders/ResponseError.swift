//
//  ResponseError.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

struct ResponseErrorsRoot: Decodable {
    let errors: [ResponseError]
}

struct ResponseError: Decodable {
    let code: String
    let detail: String
}

struct NetworkingLocalizableError: LocalizedError {
    let errorDatail: String?
    var errorDescription: String? {
        return errorDatail ?? "Unknowned Error"
    }
}


