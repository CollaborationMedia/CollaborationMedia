//
//  TMDBContent.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation

protocol PosterCellContent {
    var id: Int { get }
    var mediaType: String { get }
    var title: String { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var genreIDs: [Int] { get }
    var voteAverage: Double { get }
    var overview: String { get }
}

protocol ListCellContent {
    var id: Int { get }
    var mediaType: String { get }
    var title: String { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var voteAverage: Double { get }
    var overview: String { get }
}

struct Movie: Decodable, PosterCellContent, ListCellContent {
    let id: Int
    let mediaType: String
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]
    let voteAverage: Double
    let overview: String
}


struct TVSeries: Decodable, PosterCellContent, ListCellContent {
    let id: Int
    let mediaType: String
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]
    let voteAverage: Double
    let overview: String
    
    enum Codingkeys: String, CodingKey {
        case id
        case mediaType
        case title = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
        case overview
    }
    
    var genres: String {
        return ""
    }
    
}
