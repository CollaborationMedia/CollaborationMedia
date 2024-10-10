//
//  UserDefaultsManager.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/11/24.
//

import Foundation

enum UserDefaultsManager {
    @UserDefault(key: .movieGenres, defaultValue: [], isCustomObject: true)
    static var movieGenres: [Genre]
    
    @UserDefault(key: .tvGenres, defaultValue: [], isCustomObject: true)
    static var tvGenres: [Genre]
}
