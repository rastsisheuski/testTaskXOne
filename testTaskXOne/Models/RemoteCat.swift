//
//  RemoteCat.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

struct RemoteCat: Decodable {
    let breed: String
    let wikipediaURLString: String?
    let imageID: String?
    
    enum CodingKeys: String, CodingKey {
        case breed = "name"
        case wikipediaURLString = "wikipedia_url"
        case imageID = "reference_image_id"
    }
}


