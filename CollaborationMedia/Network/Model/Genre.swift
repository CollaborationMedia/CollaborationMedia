//
//  Genre.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
       case id
       case name
    }
}
