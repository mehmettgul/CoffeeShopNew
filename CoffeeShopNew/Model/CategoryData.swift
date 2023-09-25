//
//  CategoryData.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 22.09.2023.
//

import Foundation

struct CategoryData: Codable {
    
    var id: Int
    var previewURL: String
    var tag: String
    
    init(id: Int, previewURL: String, tag: String) {
        self.id = id
        self.previewURL = previewURL
        self.tag = tag
    }
    
}
