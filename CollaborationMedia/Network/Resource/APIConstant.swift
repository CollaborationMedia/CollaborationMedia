//
//  APIConstant.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/10/24.
//

import Foundation

enum APIConstant {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w780"
    static let videoBaseURL = "https://www.youtube.com/watch?v="
}

enum ContentType: String {
    case movie = "movie"
    case tv = "tv"
    
    var krValue: String {
        switch self {
        case .movie:
            "영화"
        case .tv:
            "TV시리즈"
        }
    }
 
}
