//
//  NetworkingHTTPClient.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

protocol NetworkingHTTPClient {
    typealias Result = (data: Data, response: HTTPURLResponse)
    
    func makeRequest(_ request: NetworkingRequest) async throws ->  Result
}
