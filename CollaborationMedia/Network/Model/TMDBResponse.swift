//
//  TMDBResponse.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation

struct TMDBResponse<Content: Decodable>: Decodable {
    var page: Int
    var results: [Content]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
