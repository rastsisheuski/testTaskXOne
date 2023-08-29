//
//  CatsListViewModel.swift
//  testTaskXOne
//
//  Created by Hleb Rastsisheuski on 29.08.23.
//

import Foundation

final class CatsListViewModel {
    
    let catGetter: CatsGetter
    
    init(catGetter: CatsGetter) {
        self.catGetter = catGetter
    }
    
    func getCats() {
        catGetter.getCats { result in
            switch result {
                case .success(let cats):
                    print("Good")
                case .failure(let error):
                    print("Shit")
            }
        }
    }
}
