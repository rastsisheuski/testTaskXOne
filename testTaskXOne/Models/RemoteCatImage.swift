//
//  RemoteCatImage.swift.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

struct RemoteCatImage: Decodable {
    let imageURLString: String
    
    enum CodingKeys: String, CodingKey {
        case imageURLString = "url"
    }
}
