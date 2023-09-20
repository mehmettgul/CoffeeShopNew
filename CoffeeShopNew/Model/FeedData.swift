//
//  FeedData.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 20.09.2023.
//

import Foundation

struct FeedData : Codable {
    
    var id: Int
    var previewURL: String
    var page: Int
    var per_page: Int
    
    init(id: Int, previewURL: String, page: Int, per_page: Int) {
        self.id = id
        self.previewURL = previewURL
        self.page = page
        self.per_page = per_page
    }
    
}
