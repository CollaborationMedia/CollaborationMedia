//
//  Credit.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation


// MARK: - Welcome
struct CreditResponse: Decodable {
    let cast, crew: [Cast]
    let id: Int
}

// MARK: - Cast
struct Cast: Decodable {
    let name: String
    let knownForDepartment: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case knownForDepartment = "known_for_department"
    }
}
