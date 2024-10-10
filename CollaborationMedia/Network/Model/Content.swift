//
//  TMDBContent.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation
import Differentiator

protocol PosterCellContent: Decodable {
    var id: Int { get }
    var mediaType: String? { get }
    var title: String? { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var genreIDs: [Int] { get }
    var voteAverage: Double { get }
    var overview: String { get }
    var posterURL: String { get }
    var backdropURL: String { get }
}

protocol ListCellContent: Decodable {
    var id: Int { get }
    var mediaType: String? { get }
    var title: String? { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var voteAverage: Double { get }
    var overview: String { get }
    var posterURL: String { get }
    var backdropURL: String { get }
}

extension PosterCellContent {
    
    var posterURL: String {
        return APIConstant.imageBaseURL + (posterPath ?? "")
    }
    var backdropURL: String {
        return APIConstant.imageBaseURL + (backdropPath ?? "")
    }
    
}

struct Movie: Decodable, PosterCellContent, ListCellContent {
    let id: Int
    let mediaType: String?
    let title: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"

    }
    
    var posterItem: PosterContent {
        return PosterContent(id: id, mediaType: mediaType, title: title, posterPath: posterPath, backdropPath: backdropPath, genreIDs: genreIDs, voteAverage: voteAverage, overview: overview)
    }
}

struct TVSeries: Decodable, PosterCellContent, ListCellContent {
    let id: Int
    let mediaType: String?
    let title: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case title = "name"
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"

    }
    
    var posterItem: PosterContent {
        return PosterContent(id: id, mediaType: mediaType, title: title, posterPath: posterPath, backdropPath: backdropPath, genreIDs: genreIDs, voteAverage: voteAverage, overview: overview)
    }
}

struct PosterContent: PosterCellContent, IdentifiableType, Hashable {
    var identity = UUID().uuidString
    var id: Int
    var mediaType: String?
    var title: String?
    var posterPath: String?
    var backdropPath: String?
    var genreIDs: [Int]
    var voteAverage: Double
    var overview: String
}
