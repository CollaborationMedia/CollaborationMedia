//
//  VedioResponse.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/10/24.
//

import Foundation

struct VideoResponse: Decodable {
    var id: Int
    var results: [Video]
}

struct Video: Decodable {
    
    var key: String
    
    var imagePath: String? {
        return key
    }
}

