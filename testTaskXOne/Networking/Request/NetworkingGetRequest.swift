//
//  NetworkingGetRequest.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

struct NetworkingGetRequest: NetworkingRequest {
    
    // MARK: -
    // MARK: - Public Properties
    
    var queryParams: [String : String]?
    var headers: [String : String]?
    
    // MARK: -
    // MARK: - Private Properties
    
    private let urlString: String
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func makeURLRequest() -> URLRequest? {
        guard var url = URL(string: urlString) else { return nil }
        
        queryParams?.forEach {
            url = url.appending($0.key, value: $0.value)
        }
        
        var request = URLRequest(url: url)
        
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        request.httpMethod = RequestRemoteMethod.get.rawValue
        
        return request
    }
}
