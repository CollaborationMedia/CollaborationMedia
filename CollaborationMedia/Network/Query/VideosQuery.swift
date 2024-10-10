//
//  VideosQuery.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/10/24.
//

import Foundation

struct VideoQuery: Encodable {
    var language = "ko-KR"
    
    enum CodingKeys: String, CodingKey {
        case language
    }
}
