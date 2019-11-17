//
//  MockDataProvider.swift
//  Cards
//
//  Created by nikita on 17/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import Foundation

class MockDataProvider {
    private let queue = DispatchQueue(label: "queue.MockDataProvider")
    
    func loadTinder(completion: @escaping (Data) -> Void) {
        queue.async {
            if let path = Bundle.main.path(forResource: "demo", ofType: "json") {
                do {
                    completion(try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe))
                } catch {
                    print("loading error \(error)")
                    // handle error
                }
            } else {
                print("no path")
            }
        }
    }
}
