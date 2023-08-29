//
//  CatsGetter.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

protocol CatsGetter {
    func getCats(completion: @escaping (Result<[Cat], Error>) -> Void)
}
