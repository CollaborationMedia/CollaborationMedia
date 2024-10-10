//
//  APIRouter.swift
//  CollaborationMedia
//
//  Created by 유철원 on 10/9/24.
//

import Foundation
import Alamofire

enum APIRouter {
    case trending(
        contentType: ContentType,
        query: TrendingQuery
    )
    case search(
        contentType: ContentType,
        query: SearchQuery
    )
    case similar(
        contentType: ContentType,
        id: Int,
        query: SimilarQuery
    )
    case genreList(
        contentType: ContentType,
        query: GenreListQuery
    )
    case credit(
        contentType: ContentType,
        id: Int,
        query: CreditQuery
    )
    
    case video (
        contentType: ContentType,
        id: Int,
        query: VideoQuery
    )
}

extension APIRouter: TargetType {
    
    var baseURL: String {
        switch self {
        default: 
            return APIConstant.baseURL
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .trending(let contentType, let query):
            return "trending/\(contentType.rawValue)/week"
        case .similar(let contentType, let id, let query):
            return "\(contentType.rawValue)/\(id)/similar"
        case .search(let contentType, let query):
            return "search/\(contentType.rawValue)"
        case .genreList(let contentType, let query):
            return "genre/\(contentType.rawValue)/list"
        case .credit(let contentType, let id, let query):
            return "\(contentType.rawValue)/\(id)/credits"
        case .video(let contentType, let id, let query):
            return  "\(contentType.rawValue)/\(id)/videos"
        }
    }
    
    var headers: Alamofire.HTTPHeaders {
        ["Authorization" : APIKey.bearerKey,
         "Accept" : "application/json"]
    }
    
    var parameters: (any Encodable)? {
        return switch self {
        case .trending(let contentType, let query): query
        case .search(let contentType, let query): query
        case .similar(let contentType, let id, let query): query
        case .genreList(let contentType, let query): query
        case .credit(let contentType, let id, let query): query
        case .video(let contentType, let id, let query): query
        }
    }
    
    var encoder: any Alamofire.ParameterEncoder {
        return URLEncodedFormParameterEncoder.default
    }
    
}

