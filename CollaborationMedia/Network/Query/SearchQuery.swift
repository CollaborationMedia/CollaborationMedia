//
//  SearchQuery.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/10/24.
//

import Foundation

struct SearchQuery: Encodable {
    var query: String
    var includeAdult = false
    var language = "ko-KR"
    var page: Int
    
    enum CodingKeys: String, CodingKey {
        case query
        case includeAdult = "include_adult"
        case language
        case page
    }
}


