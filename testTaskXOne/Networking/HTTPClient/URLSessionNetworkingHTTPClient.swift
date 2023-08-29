//
//  URLSessionNetworkingHTTPClient.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

final class URLSessionNetworkingHTTPClient: NetworkingHTTPClient {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func makeRequest(_ request: NetworkingRequest) async throws -> NetworkingHTTPClient.Result {
        guard let urlRequest = request.makeURLRequest() else {
            throw Error.invalidURL
        }
        
        do {
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            
            if let httpResponse = urlResponse as? HTTPURLResponse {
                return (data, httpResponse)
            } else {
                throw Error.invalidResponse
            }
        } catch {
            throw Error.serverError
        }
    }
}

extension URLSessionNetworkingHTTPClient {
    enum Error: LocalizedError {
        case invalidURL
        case invalidResponse
        case serverError
        
        var errorDescription: String? {
            switch self {
                case .invalidURL:       return "Error! Invalid URL."
                case .invalidResponse:  return "Error! Invalid response."
                case .serverError:      return "Error! Unknown server error, please, try again."
            }
        }
    }
}
