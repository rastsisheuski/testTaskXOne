//
//  NetworkingRequest.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

enum RequestRemoteMethod: String {
    case get = "GET"
}

protocol NetworkingRequest {
    var queryParams: [String: String]? { get set }
    var headers: [String: String]? { get set }
    
    init(urlString: String)
    
    func makeURLRequest() -> URLRequest? 
}
