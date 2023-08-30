//
//  CatsListRemoteAPI.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

final class CatsListRemoteAPI:CatsGetter {
    
    // MARK: -
    // MARK: - Private Properties
    
    private let httpClient: NetworkingHTTPClient
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(httpClient: NetworkingHTTPClient) {
        self.httpClient = httpClient
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func getCats(page: Int, completion: @escaping (Result<[Cat], Error>) -> Void) {
        Task {
            do {
                let remoteCats = try await getRemoteCats(page: page)
                var catsArray: [Cat] = []
                for cat in remoteCats {
                    guard let imageId = cat.imageID else { continue }
                    
                    let remoteCatImage = try await getImageURL(by: imageId)

                    let cat = Cat(breed: cat.breed,
                                  catImageURLString: remoteCatImage.imageURLString,
                                  wikipediaURLString: cat.wikipediaURLString)
                    catsArray.append(cat)
                }
                completion(.success(catsArray))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func getRemoteCats(page: Int) async throws -> [RemoteCat] {
        let urlString = API.baseURL + "breeds"
        var getRequest = NetworkingGetRequest(urlString: urlString)
        
        getRequest.queryParams = ["limit": "10", "page": "\(page)"]
        
        do {
            let result = try await httpClient.makeRequest(getRequest)
            let decoder = ResponseErrorDecoder()
            let error = decoder.decode(response: result.response, data: result.data)
            guard error == nil else {
                throw error!
            }
            let remoteCats = try JSONDecoder().decode([RemoteCat].self, from: result.data)
            
            return remoteCats
        } catch {
            throw error
        }
    }
    
    private func getImageURL(by imageID: String) async throws -> RemoteCatImage {
        let urlString = API.baseURL + "images/\(imageID)"
        let getRequest = NetworkingGetRequest(urlString: urlString)
        
        do {
            let result = try await httpClient.makeRequest(getRequest)
            let decoder = ResponseErrorDecoder()
            let error = decoder.decode(response: result.response, data: result.data)
            guard error == nil else {
                throw error!
            }
            let remoteCatImage = try JSONDecoder().decode(RemoteCatImage.self, from: result.data)
            
            return remoteCatImage
        } catch {
            throw error
        }
    }
}
