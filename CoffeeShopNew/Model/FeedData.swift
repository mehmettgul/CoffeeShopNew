//
//  FeedData.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 20.09.2023.
//

import Foundation

struct FeedData : Codable, Equatable {
    
    var id: Int
    var previewURL: String
    
    init(id: Int, previewURL: String) {
        self.id = id
        self.previewURL = previewURL
    }
    
    static func == (lhs: FeedData, rhs: FeedData) -> Bool {
        return lhs.id == rhs.id && lhs.previewURL == rhs.previewURL
    }
}
